//
//  CharacterCell.swift
//  RickAndMortySDP
//
//  Created by María Pérez  on 16/12/24.
//

import SwiftUI

struct CharacterCell: View {
    let character: CharacterModel
    @Environment(FavoritesVM.self) var favVM
    @Environment(RickyMortyListVM.self) var vm
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(character.name)
                Text(character.species)
            }
            Spacer()
            Image(systemName: "star.fill")
                .foregroundStyle(favVM.checkFavorite(character: character) ? .yellow : .clear)
            CharacterPoster(imageURL: character.image)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 80, height: 80)
        }
        .onAppear {
            vm.loadNextPage(character: character)
        }
        .swipeActions {
            Button {
                favVM.saveFavorite(character: character)
            } label: {
                Image(systemName: favVM.checkFavorite(character: character) ? "star" : "person")
                    .tint(favVM.checkFavorite(character: character) ? .yellow : .gray)
            }
        }
    }
}

#Preview {
    CharacterCell(character: .preview)
        .environment(FavoritesVM())
        .environment(RickyMortyListVM.preview)
}
