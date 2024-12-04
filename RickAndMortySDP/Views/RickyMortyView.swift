//
//  ContentView.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import SwiftUI

struct RickyMortyView: View {
    @State var vm = RickyMortyListVM()
    @State private var timer: Timer?
    
    var body: some View {
        NavigationStack {
            listSearch
                .alert("Something went wrong", isPresented: $vm.showAlert, actions: {
                    Button {
                        Task {
                            await vm.loadCharacters()
                        }
                    } label: {
                        Text("Reload")
                    }
                    
                }, message: {
                    Text(vm.errorMessage)
                })
                .navigationTitle("Rick Characters")
                .navigationDestination(for: CharacterModel.self) { character in
                    Text(character.name)
                }
                .searchable(text: $vm.searchedName, prompt: "Search character")
                .animation(.easeInOut, value: vm.characters)
                .onChange(of: vm.searchedName) {
                    timer = .scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
                        Task { @MainActor in
                            vm.searchCharacter()
                        }
                    }
                    /*Task {
                     vm.delay5SecAlberto()
                     }*/
                    
                }
                .onChange(of: vm.characterStatus) {
                    vm.resetInitialValue()
                    Task {
                        await vm.loadCharacters()
                    }
                }
                .task {
                    await vm.loadCharacters()
                }
                .customToolBar(charStatus: $vm.characterStatus)
        }
        
    }
    
    @ViewBuilder
    var listSearch: some View {
        if vm.characters.isEmpty {
            ContentUnavailableView("No character found", systemImage: "person", description: Text("No character found with name '\(vm.searchedName)'"))
        } else {
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
