//
//  RickyMortyListVM.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

@Observable
final class RickyMortyListVM {
    let repository: ProtocolMorty
    var characters = [CharacterModel]()
    
    var page: Int = 1
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
        Task {
            await loadCharacters()
        }
    }
    
    func loadCharacters() async {
        do {
            characters = try await repository.getRickMortyModel(page: String(page)).results
        } catch let error as NetWorkError {
            print("error: \(error.localizedDescription)")
        } catch {
            print("error \(error)")
        }
    }
}

