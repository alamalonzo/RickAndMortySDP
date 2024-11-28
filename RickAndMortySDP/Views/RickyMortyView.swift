//
//  ContentView.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import SwiftUI

struct RickyMortyView: View {
    @State var vm = RickyMortyListVM()
    
    var body: some View {        
        NavigationStack {
            List(vm.characters) { character in
                NavigationLink(value: character) {
                    characterCell(character: character)
                    .onAppear {
                        vm.loadNextPage(character: character)
                    }
                    .swipeActions {
                        Button {
                            
                        } label: {
                            Image(systemName: "star")
                        }

                    }
                }
            }
            .navigationTitle("Rick Characters")
            .navigationDestination(for: CharacterModel.self) { character in
                Text(character.name)
            }
        }

    }
    func characterCell(character: CharacterModel) -> some View {
        HStack {
            VStack(alignment: .leading){
                Text(character.name)
                Text(character.species)
            }
            Spacer()
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .clipShape(.circle)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    RickyMortyView(vm: .preview)
}
