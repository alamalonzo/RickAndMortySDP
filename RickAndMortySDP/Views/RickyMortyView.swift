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
        List(vm.characters) { character in
            VStack(alignment: .leading){
                Text(character.name)
                Text(character.species)
            }
        }
    }
}

#Preview {
    RickyMortyView(vm: .preview)
}
