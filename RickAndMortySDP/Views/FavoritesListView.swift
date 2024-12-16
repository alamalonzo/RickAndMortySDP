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
        List(vm.favChars) { character in
            Text(character.name)
        }
    }
}

#Preview {
    FavoritesListView()
        .environment(FavoritesVM())
}
