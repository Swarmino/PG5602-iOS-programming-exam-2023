//
//  RecipeListView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI

struct RecipeListView: View {
    
    var recipesAdded: Bool = false
    
    var body: some View {
        ZStack{
            
            if (!recipesAdded) {
                NoRecipesFavouriteView()
            } else {
                Text("Recipes added")
            }
            
        }
    }
}

struct NoRecipesFavouriteView: View {
    var body: some View {
        VStack{
            Spacer()
            Image(systemName: "tray").resizable().frame(width: 100, height: 80)
            Text("No recipes added to favourite")
            Spacer()
        }.opacity(0.2)
    }
}

#Preview {
    RecipeListView()
}
