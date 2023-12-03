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
                
                Section(header: Text("Oppskrifter")) {
                    if meals.isEmpty {
                        HStack{
                            Text("Ingen arkiverte oppskrifter")
                        }
                    } else {
                        List {
                            ForEach(meals) { meal in
                                Text("\(meal.name!)")
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        Button {
                                            withAnimation {
                                                restoreMeal(meal: meal)
                                            }
                                        } label: {
                                            Label("Gjenopprett", systemImage: "trash.slash")
                                        }
                                        .tint(.green)
                                    }
                            }
                            .onDelete(perform: deleteMeals)
                        }
                    }
                }
                
                Section(header: Text("Ingredienser")) {
                    if ingredients.isEmpty {
                        HStack{
                            Text("Ingen arkiverte ingredienser")
                        }
                    } else {
                        List {
                            ForEach(ingredients) { ingredient in
                                Text("\(ingredient.name!)")
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        Button {
                                            withAnimation {
                                                restoreIngredient(ingredient: ingredient)
                                            }
                                        } label: {
                                            Label("Gjenopprett", systemImage: "trash.slash")
                                        }
                                        .tint(.green)
                                    }
                            }
                            .onDelete(perform: deleteIngredients)
                        }
                    }
                }
                
                Section(header: Text("Områder")) {
                    if areas.isEmpty {
                        HStack{
                            Text("Ingen arkiverte områder")
                        }
                    } else {
                        List {
                            ForEach(areas) { area in
                                Text("\(area.name!)")
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        Button {
                                            withAnimation {
                                                restoreArea(area: area)
                                            }
                                        } label: {
                                            Label("Gjenopprett", systemImage: "trash.slash")
                                        }
                                        .tint(.green)
                                    }
                            }
                            .onDelete(perform: deleteArea)
                        }
                    }
                }
                
                Section(header: Text("Kategorier")) {
                    if categories.isEmpty {
                        HStack{
                            Text("Ingen arkiverte kategorier")
                        }
                    } else {
                        List {
                            ForEach(categories) { category in
                                Text("\(category.name!)")
                                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                        Button {
                                            withAnimation {
                                                restoreCategory(category: category)
                                            }
                                        } label: {
                                            Label("Gjenopprett", systemImage: "trash.slash")
                                        }
                                        .tint(.green)
                                    }
                            }
                            .onDelete(perform: deleteCategory)
                        }
                    }
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
    
    private func restoreMeal(meal: Meal) {
        withAnimation {
            meal.archived = false
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func restoreIngredient(ingredient: Ingredient) {
        withAnimation {
            ingredient.archived = false
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func restoreArea(area: Area) {
        withAnimation {
            area.archived = false
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func restoreCategory(category: Category) {
        withAnimation {
            category.archived = false
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
