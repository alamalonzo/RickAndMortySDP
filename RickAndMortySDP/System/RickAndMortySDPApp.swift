//
//  RickAndMortySDPApp.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import SwiftUI


@main
struct RickAndMortySDPApp: App {
    @State var vm = RickyMortyListVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(vm)
        }
    }
}
