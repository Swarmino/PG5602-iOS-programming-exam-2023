//
//  ContentView.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 14/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    //@Environment(\.managedObjectContext) private var viewContext
    
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    
    var body: some View {
        
        TabView() {
            
            SplashView().tabItem {
                VStack{
                    Image(systemName: "house")
                    Text("Home")
                }
            }
            
            TestView().tabItem {
                VStack{
                    Image(systemName: "house")
                    Text("Core data test view")
                }
            }
            
            SearchView().tabItem {
                VStack{
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }
            
            RecipeListView().tabItem {
                VStack{
                    Image(systemName: "fork.knife")
                    Text("My recipes")
                }
            }
            
            SettingsView().tabItem {
                VStack{
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }
        }
        
        //        NavigationView {
        //            List {
        //                ForEach(meals) { meal in
        //                    NavigationLink {
        //                        Text(meal.name!)
        //                    } label: {
        //                        Text(meal.name!)
        //                    }
        //                }
        //                .onDelete(perform: deleteItems)
        //            }
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    EditButton()
        //                }
        //                ToolbarItem {
        //                    Button(action: addItem) {
        //                        Label("Add Item", systemImage: "plus")
        //                    }
        //                }
        //            }
        //            Text("Select an item")
        //        }
        
    }
    
    //    private func addMeal() {
    //        let newMeal = Meal(context: viewContext)
    //        newMeal.name = "Test Name"
    //        newMeal.area = Area.init()
    //        newMeal.category = Category.init()
    //        newMeal.ingredients = Ingredient.init()
    //    }
    
    struct TestView: View {
        
        @Environment (\.managedObjectContext) private var moc
        @FetchRequest (sortDescriptors: []) var meals: FetchedResults<Meal>
        
        var body: some View {
            VStack {
                List {
                    ForEach(meals) { meal in
                        NavigationLink {
                            VStack{
                                Text(meal.name ?? "unkown")
                            }
                        } label: {
                            Text(meal.name ?? "unkown")
                        }
                    }
                }
                Button("add") {
                    let mealFirstName = ["Fried", "Skewerd", "Roasted", "Sauteed", "Cooked", "Cooked", "Fried"]
                    let mealLastName = ["Chicken", "Beef", "Potatoes", "Sausage", "Rice", "Soup", "Pizza"]
                    
                    let chosenFirstName = mealFirstName.randomElement()!
                    let chosenLastName = mealLastName.randomElement()!
                    
                    let newMeal = Meal.init(context: moc)
                    
                    newMeal.name = "\(chosenFirstName) \(chosenLastName)"
                    
                    try? moc.save()
                    //moc.delete(meal)
                }
            }
            
        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    //
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { meals[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

#Preview {
    ContentView()
    
    //.preferredColorScheme(.dark)
}
