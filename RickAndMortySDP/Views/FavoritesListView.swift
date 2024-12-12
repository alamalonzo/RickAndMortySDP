//
//  FavoritesListView.swift
//  RickAndMortySDP
//
//  Created by María Pérez  on 28/11/24.
//

import SwiftUI

struct FavoritesListView: View {    
    @Environment(RickyMortyListVM.self) var vm
    
    var body: some View {
        List(vm.favoritesCharacters) { character in
            Text(character.name)
        }
    }
}

#Preview {
    FavoritesListView()
        .environment(RickyMortyListVM.preview)
}
