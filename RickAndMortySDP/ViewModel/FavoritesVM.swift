//
//  FavoritesVM.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 16/12/24.
//

import Foundation

@Observable
final class FavoritesVM {
    let repository = FavoriteRepository()
    
    var favChars: [CharacterModel] = [] {
        didSet {
            try? repository.saveJSON(characters: favChars)
        }
    }
    
    init() {
        loadFavorites()
    }
    
    func loadFavorites() {
        do {
            favChars = try repository.getFavorites()
        } catch {
            //do something here
            print(error)
        }
    }
    
    func saveFavorite(character: CharacterModel) {
        if favChars.contains(where: { $0.id == character.id }) {
            favChars.removeAll { $0.id == character.id }
        } else {
            favChars.append(character)
        }
    }
    
    func checkFavorite(character: CharacterModel) -> Bool {
        favChars.contains { $0.id == character.id }
    }
    
}
