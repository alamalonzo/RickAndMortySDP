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
    private var searchTask: Task<Void, Never>?
    
    private var page: Int = 1
    var searchedName: String = ""
    
    var errorMessage = ""
    var showAlert = false
    
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
    }
    
    
}

@MainActor
extension RickyMortyListVM {
    func loadCharacters() async {
        do {
            let rickInfo = try await repository.getRickMortyModel(page: String(page), name: searchedName)
            self.rickInfo = rickInfo
            characters += rickInfo.results
        } catch {
            errorMessage = error.errorDescription
            showAlert = true
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
    
    func searchCharacter() {
        characters.removeAll()
        Task {
            await loadCharacters()
        }
    }
    
    func delay5SecAlberto() {
        characters.removeAll()
        searchTask?.cancel()
        searchTask = nil
        searchTask = Task {
            do {
                try await Task.sleep(for: .seconds(0.6))
                await loadCharacters()
            } catch {}
        }
    }
}


