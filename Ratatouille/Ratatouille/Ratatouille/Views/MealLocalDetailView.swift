//
//  MealLocalDetailView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 03/12/2023.
//

import SwiftUI

struct MealLocalDetailView: View {
    
    let meal: Meal
    
    var body: some View {
        VStack {
            Text(meal.name!)
                .font(.title)
                .padding()
            
            Text("Ingredienser:")
                .font(.title2)
                .padding()
            
            let ingredientArray = meal.ingredient?.allObjects
            
            List {
                ForEach(ingredientArray as! [Ingredient]) { ingredient in
                    Text("\(ingredient.name!)")
                }
            }
            
            Text(meal.instructions!)
                .padding()
            Spacer()
        }
    }
}
