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
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

//#Preview {
//    DetailViewRickAndMorty()
//}
