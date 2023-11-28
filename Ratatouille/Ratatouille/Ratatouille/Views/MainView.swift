//
//  MainView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 28/11/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            RecipeView().tabItem{
                Label("Recipes", systemImage: "book.pages")
            }
            SearchView().tabItem{
                Label("Search", systemImage: "magnifyingglass")
            }
            SettingsView().tabItem{
                Label("Settings", systemImage: "gearshape")
            }
        }
    }
}

#Preview {
    MainView()
}
