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
    var rickInfo: RickMortyModel?
    
    private var page: Int = 1
    var searchedName: String = ""
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
    }
    
    @MainActor
    func loadCharacters() async {
        do {
            let rickInfo = try await repository.getRickMortyModel(page: String(page), name: searchedName)
            self.rickInfo = rickInfo
            characters += rickInfo.results
        } catch let error as NetWorkError {
            print("error: \(error.localizedDescription)")
        } catch {
            print("error \(error)")
        }
    }
    
    private func isLastItem(character: CharacterModel) -> Bool {
        characters.last?.id == character.id
    }
    
    @MainActor
    func loadNextPage(character: CharacterModel) {
        guard let info = rickInfo,
              let _ = info.info.next else { return }
        if isLastItem(character: character) {
            page += 1
            Task {
                await loadCharacters()
            }
        }
    }
    
    @MainActor
    func searchCharacter() {
        characters.removeAll()
        
        Task {
            await loadCharacters()
        }
    }
}

