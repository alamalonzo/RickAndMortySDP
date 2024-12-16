//
//  RickAndMortySDPApp.swift
//  RickAndMortySDP
//
//  Created by  on 25/11/24.
//

import SwiftUI


@main
struct RickAndMortySDPApp: App {
    @State var vm = RickyMortyListVM()
    @State var favVM = FavoritesVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(vm)
                .environment(favVM)
        }
    }
}
