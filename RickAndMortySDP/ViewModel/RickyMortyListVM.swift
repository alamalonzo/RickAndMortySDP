//
//  RickyMortyListVM.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

enum ViewListStatus {
    case loading, error,loaded
}

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
    
    var characterStatus: CharacterStatus = .all
    var viewListStatus: ViewListStatus = .loading
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
    }
    
    func resetInitialValue() {
        page = 1
        characters.removeAll()
    }
}

@MainActor
extension RickyMortyListVM {
    func loadCharacters() async {
        do {
            viewListStatus = .loading

#warning("Esto simula una carga mas lenta.")
            try? await Task.sleep(for: .seconds(1))
            let rickInfo = try await repository.getRickMortyModel(page: String(page), name: searchedName, status: characterStatus)
            self.rickInfo = rickInfo
            characters += rickInfo.results
            viewListStatus = .loaded
        } catch {
            errorMessage = error.errorDescription
            showAlert = true
            viewListStatus = .error
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


