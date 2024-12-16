//
//  DetailViewRickAndMorty.swift
//  RickAndMortySDP
//
//  Created by  on 5/12/24.
//

import SwiftUI

struct DetailViewRickAndMorty: View {
    let character: CharacterModel
    @Environment(FavoritesVM.self) var favVM
    
    var body: some View {
        VStack {
            CharacterPoster(imageURL: character.image)
                .frame(width: 200)
            HStack {
                Button {
                    favVM.saveFavorite(character: character)
                } label: {
                    Text(favVM.checkFavorite(character: character) ? "Remove fav" : "Add a fav")
                }

            }
            
        }
    }
}

#Preview {
    DetailViewRickAndMorty(character: CharacterModel.preview)
        .environment(FavoritesVM())
}
