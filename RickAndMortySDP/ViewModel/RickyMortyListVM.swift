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
    var newPageLoading: Bool = false
    
    var favoritesCharacters: [CharacterModel] {
        characters.filter { $0.isFavorite }
    }
    
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
            let rickInfo = try await repository.getRickMortyModel(page: String(page), name: searchedName, status: characterStatus)
            self.rickInfo = rickInfo
            characters += rickInfo.results
            newPageLoading = false
            viewListStatus = .loaded
        } catch {
            if searchedName.isEmpty {
                errorMessage = error.errorDescription
                viewListStatus = .error
            } else {
                viewListStatus = .loaded
            }
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
            newPageLoading.toggle()
            Task {
                await loadCharacters()
            }
            
        }
    }
    
    func searchCharacter() {
        characters.removeAll()
        viewListStatus = .loading
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
    
    func markAsFavorite(character: CharacterModel) {
        if let index = characters.firstIndex(where: { $0.id == character.id }) {
            characters[index].isFavorite.toggle()
        }
    }
}


