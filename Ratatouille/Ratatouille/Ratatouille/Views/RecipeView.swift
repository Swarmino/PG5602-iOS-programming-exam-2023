//
//  RecipeView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 28/11/2023.
//

import SwiftUI
import CoreData

struct RecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Meal.favourite, ascending: false),
            NSSortDescriptor(keyPath: \Meal.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: false)),
        animation: .default)
    
    private var meals: FetchedResults<Meal>
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(meals) { meal in
                    NavigationLink {
                        Text("Meal at \(meal.name!)")
                    } label: {
                        Text("\(meal.name!)")
                    }
                }
                .onDelete(perform: ArchiveMeal)

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addMeal) {
                        Label("Add Meal", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addMeal() {
        withAnimation {
            let newMeal = Meal(context: viewContext)
            newMeal.id = UUID()
            newMeal.name = "Potato"
            newMeal.favourite = false
            newMeal.archived = false
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func ArchiveMeal(offsets: IndexSet) {
        withAnimation {
            offsets.map { meals[$0] }.forEach { meal in
                meal.archived = true
            }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



#Preview {
    RecipeView()
}
