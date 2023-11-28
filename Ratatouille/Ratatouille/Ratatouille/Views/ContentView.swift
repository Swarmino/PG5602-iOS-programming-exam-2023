//
//  ContentView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 27/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        MainView()
    }
    
    struct MealAddView: View {
        
        @Environment(\.managedObjectContext) private var viewContext
        
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Meal.name, ascending: true)],
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
                    .onDelete(perform: deleteMeals)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addMeal) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
                Text("Select an item")
            }
        }
        
        private func addMeal() {
            withAnimation {
                let newMeal = Meal(context: viewContext)
                newMeal.id = UUID()
                newMeal.name = "Potato"
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private func deleteMeals(offsets: IndexSet) {
            withAnimation {
                offsets.map { meals[$0] }.forEach(viewContext.delete)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
