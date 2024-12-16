//
//  PreviewData.swift
//  RickAndMortySDP
//
//  Created by  on 26/11/24.
//

import Foundation

struct RepositoryMortyPreview: ProtocolMorty {
    func getRickMortyModel(page: String, name: String, status: CharacterStatus) async throws(NetWorkError) -> RickMortyModel {
        do {
            let url = Bundle.main.url(forResource: "RickMortyMockData", withExtension: "json")!
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
            return try decoder.decode(RickMortyModelDTO.self, from: data).mapToModel
        } catch {
            throw .generalError(error)
        }
    }
}

extension CharacterModel {
    static let preview = CharacterModel(
        id: 1,
        name: "Alberto",
        status: .unknown,
        species: "Humano",
        gender: "Male",
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg")!,
        created: .now,
        origin: CharacterOriginModel(name: "Tierra"),
        isFavorite: false
    )
}

@MainActor
extension RickyMortyListVM {
    static let preview = RickyMortyListVM(repository: RepositoryMortyPreview())
}


