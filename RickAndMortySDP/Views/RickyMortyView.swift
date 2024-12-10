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
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            VStack {
                switch vm.viewListStatus {
                case .loading:
                    ProgressView()
                case .error:
                    CustomErrorView(
                        errorTitle: "Something went wrong",
                        errorMessage: vm.errorMessage) {
                            Task {
                                await vm.loadCharacters()
                            }
                        }
                case .loaded:
                    listSearch
                    
                }
            }
            .navigationTitle("Rick Characters")
            .navigationDestination(for: CharacterModel.self) { character in
                DetailViewRickAndMorty(character: character)
                    .navigationTransition(.zoom(sourceID: character, in: namespace))
            }
            .searchable(text: $vm.searchedName, prompt: "Search character")
            .animation(.easeInOut, value: vm.characters)
            .onChange(of: vm.searchedName) {
                timer?.invalidate()
                timer = .scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                    Task { @MainActor in
                        vm.searchCharacter()
                    }
                }
            }
            .onChange(of: vm.characterStatus) {
                vm.resetInitialValue()
                Task {
                    await vm.loadCharacters()
                }
            }
            .task {
                if vm.characters.isEmpty {
                    await vm.loadCharacters()
                }
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
            .overlay(alignment: .bottom) {
                if vm.newPageLoading {
                    ProgressView()
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
            CharacterPoster(imageURL: character.image)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 80, height: 80)
        }
    }
}

#Preview {
    RickyMortyView(vm: .preview)
}



