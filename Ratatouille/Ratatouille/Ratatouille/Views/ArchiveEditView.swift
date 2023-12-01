//
//  ArchiveEditView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 01/12/2023.
//

import SwiftUI
import CoreData

struct ArchiveEditView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Meal.favourite, ascending: false),
            NSSortDescriptor(keyPath: \Meal.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: true)),
        animation: .default)
    private var meals: FetchedResults<Meal>
    
    @FetchRequest (
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: true)),
        animation: .default)
    private var ingredients: FetchedResults<Ingredient>
    
    @FetchRequest (
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Area.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: true)),
        animation: .default)
    private var areas: FetchedResults<Area>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: true)),
        animation: .default)
    private var categories: FetchedResults<Category>
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("Archived meals")) {
                if meals.isEmpty {
                    HStack{
                        Text("No archived meals")
                    }
                } else {
                        List {
                            ForEach(meals) { meal in
                                Text("\(meal.name!)")
                            }
                            .onDelete(perform: deleteMeals)
                        }
                    }
                }
            Section(header: Text("Archived Ingredients")) {
                Text("Ingredients")
            }
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
    
    private func deleteIngredients(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteArea(offsets: IndexSet) {
        withAnimation {
            offsets.map { areas[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteCategory(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(viewContext.delete)
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
    ArchiveEditView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
