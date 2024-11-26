//
//  RepositoryMorty.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

protocol ProtocolMorty {
    func getRickMortyModel() async throws -> RickMortyModel
}

struct RepositoryMortyAPI: ProtocolMorty {
    func getRickMortyModel() async throws -> RickMortyModel {
        let (data, response) = try await URLSession.shared.data(from: .characterURL)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetWorkError.nonHTTP }
        
        if httpResponse.statusCode == 200 {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
            print("Estoy llamando a red")
            return try decoder.decode(RickMortyModelDTO.self, from: data).mapToModel
        } else {
            throw NetWorkError.badStatusCode(httpResponse.statusCode)
        }
    }
}

extension URLSession {
    static func getData(url: URL) async throws -> (Data,HTTPURLResponse) {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetWorkError.nonHTTP }
        return (data, httpResponse)
    }
}





