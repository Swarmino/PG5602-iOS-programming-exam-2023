

import SwiftUI

struct IngredientEditView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Ingredient.name, ascending: true)
        ],
        predicate: NSPredicate(format: "archived == %@", NSNumber(value: false)),
        animation: .default)
    var ingredients: FetchedResults<Ingredient>
    
    var body: some View {
        NavigationView{
            List {
                ForEach(ingredients) { ingredient in
                    IngredientListView(ingredient: ingredient)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                ArchiveIngredient(ingredient: ingredient)
                            } label: {
                                Label("Arkiver", systemImage: "archivebox")
                            }
                            .tint(.blue)
                        }
                }
            }
        }.navigationTitle("Rediger Ingredienser")
    }
    
    func ArchiveIngredient(ingredient: Ingredient) {
        ingredient.archived = true
        try? viewContext.save()
    }
}
    
    struct IngredientListView: View {
        
        let ingredient: Ingredient
        
        var body: some View {
            HStack {
                Text(ingredient.name!)
            }
        }
    }

#Preview {
    IngredientEditView()
}
