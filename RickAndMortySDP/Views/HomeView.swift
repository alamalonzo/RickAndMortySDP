//
//  HomeView.swift
//  RickAndMortySDP
//
//  Created by María Pérez  on 28/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab {
                RickyMortyView()
            } label: {
                Label("Characters", systemImage: "person")
            }
            Tab {
                FavoritesListView()
            } label: {
                Label("Favorites", systemImage: "star")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(RickyMortyListVM.preview)
        .environment(FavoritesVM())
}
