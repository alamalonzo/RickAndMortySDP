//
//  DetailViewRickAndMorty.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 5/12/24.
//

import SwiftUI

struct DetailViewRickAndMorty: View {
    let character: CharacterModel
    var body: some View {
        VStack {
            CharacterPoster(imageURL: character.image)
                .frame(width: 200)
        }
    }
}

#Preview {
    DetailViewRickAndMorty(character: CharacterModel.preview)
}
