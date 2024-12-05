//
//  ImageDownloader.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 5/12/24.
//

import Foundation
import SwiftUI


actor ImageDownloader {
    static let shared = ImageDownloader()
    
    private enum ImageStatus {
        case downloading(task: Task<UIImage,Error>)
        case downloaded(image: UIImage)
    }
    
    private var cache: [URL: ImageStatus] = [:]
    
    func getImage(url: URL) async throws -> UIImage {
        if let status = cache[url] {
            switch status {
            case .downloading(let task):
                return try await task.value
            case .downloaded(let image):
                return image
            }
        }
        
        let task = Task { try await getNetworkImage(url: url) }
        cache[url] = .downloading(task: task)
        
        do {
            let image = try await task.value //10seg
            cache[url] = .downloaded(image: image)
            try await saveImageToCache(url: url)
            return image
        } catch {
            cache.removeValue(forKey: url)
            throw error
        }
    }
    
    
    func getNetworkImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
        return image
    }
    
    func saveImageToCache(url: URL) async throws {
        let imageCache = cache[url]
        let imageName = url.lastPathComponent
        let pathCache = URL.cachesDirectory.appending(path: imageName)
        
        if case .downloaded(let image) = imageCache,
           let uiImage = await image.byPreparingThumbnail(ofSize: image.size),
           let heicData = uiImage.heicData() {
            
            try heicData.write(to: pathCache, options: .atomic)
            cache.removeValue(forKey: url)
        }
        
    }
}
