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
    
    private func getNetworkImage(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else { throw URLError(.badServerResponse) }
        return image
    }
    
    private func saveImageToCache(url: URL) async throws {
        guard let imageCache = cache[url] else { return }
        let imageName = url.lastPathComponent // ultimo
        let pathCache = URL.cachesDirectory.appending(path: imageName)
        
    
        if case .downloaded(let image) = imageCache,
           let uiImage = await image.byPreparingThumbnail(ofSize: image.size),
           let heicData = uiImage.heicData() {
            
            try heicData.write(to: urlDoc(url: pathCache), options: .atomic)
//            print(pathCache)
            cache.removeValue(forKey: url)
        }
        
    }
    
    nonisolated func urlDoc(url: URL) -> URL {
        let path = url.deletingPathExtension().appendingPathExtension("heic").lastPathComponent
        return URL.cachesDirectory.appending(path: path)
    }
}
