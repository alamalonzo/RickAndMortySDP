//
//  FavoritesListView.swift
//  RickAndMortySDP
//
//  Created by María Pérez  on 28/11/24.
//

import SwiftUI

struct FavoritesListView: View {    
    @Environment(FavoritesVM.self) var vm
    
    var body: some View {
        NavigationStack {
            List(vm.favChars) { character in
                NavigationLink(value: character) {
                    CharacterCell(character: character)
                }
            }
            .navigationTitle("Favorites")
            .navigationDestination(for: CharacterModel.self) { character in
                DetailViewRickAndMorty(character: character)
            }
        }
    }
}

#Preview {
    FavoritesListView()
        .environment(FavoritesVM())
}
