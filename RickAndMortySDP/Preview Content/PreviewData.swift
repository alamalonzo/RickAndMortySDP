//
//  PreviewData.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 26/11/24.
//

import Foundation

struct RepositoryMortyPreview: ProtocolMorty {
    func getRickMortyModel() async throws -> RickMortyModel {
        let url = Bundle.main.url(forResource: "RickMortyMockData", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
        return try decoder.decode(RickMortyModelDTO.self, from: data).mapToModel
    }
}

extension RickyMortyListVM {
    static let preview = RickyMortyListVM(repository: RepositoryMortyPreview())
}


