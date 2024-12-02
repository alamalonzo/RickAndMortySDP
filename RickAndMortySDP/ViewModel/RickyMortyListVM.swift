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
    
    var page: Int = 1
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
        Task {
            await loadCharacters()
        }
    }
    
    @MainActor
    func loadCharacters() async {
        do {
            let rickInfo = try await repository.getRickMortyModel(page: String(page))
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
}

