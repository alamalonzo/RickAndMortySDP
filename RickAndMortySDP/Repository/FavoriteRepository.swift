//
//  RepositoryLocal.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 16/12/24.
//

import Foundation

struct FavoriteRepository {
    let url = URL.documentsDirectory.appending(path: "favorites.json")
    
    func getFavorites() throws -> [CharacterModel] {
        if FileManager.default.fileExists(atPath: url.path()) {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([CharacterModel].self, from: data)
        } else {
            return []
        }
    }
    
    func saveJSON(characters: [CharacterModel]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(characters)
        try data.write(to: url, options: [.atomic, .completeFileProtection])
    }
}
