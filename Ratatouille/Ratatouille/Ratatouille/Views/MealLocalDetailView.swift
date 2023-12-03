import SwiftUI

struct MealLocalDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let meal: Meal
    @State private var editedInstructions: String = ""
    @State private var editedTitle: String = ""
    @State private var newIngredient: Ingredient?
    
    @State private var ingredients: [Ingredient] = []
    
    var body: some View {
        
        @State var currentTitle = meal.name!
        
        ScrollView {
            VStack {
                HStack {
                    Text(currentTitle)
                        .font(.title)
                        .padding()
                        .onChange(of: editedTitle) { newValue in
                            currentTitle = newValue
                        }
                    Button(action: editTitle) {
                        Image(systemName: "pencil")
                    }
                }
                
                var ingredients = meal.ingredient?.allObjects
                VStack{
                    HStack{
                        Text("Ingredienser:")
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                            addIngredient()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    VStack {
                        ForEach(ingredients as! [Ingredient], id: \.self) { ingredient in
                                Text(ingredient.name!)
                        }
                    }
                    .padding()
                    .onChange(of: meal.ingredient) { newValue in
                        ingredients = meal.ingredient?.allObjects
                    }
                    
                
                Section(header: Text("Tilberedning:").font(.title2)) {
                        Text(meal.instructions!)
                            .onChange(of: editedInstructions) { newValue in
                                meal.instructions = newValue
                            }
                }
                
                }
            }
        }
    }
    
    private func editTitle() {
        let alert = UIAlertController(title: "Edit title", message: "Enter new title", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [self] _ in
            editedTitle = alert.textFields![0].text!
            meal.name = editedTitle
            save()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    private func addIngredient() {
        let alert = UIAlertController(title: "Add ingredient", message: "Enter new ingredient", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [self] _ in
            let newIngredient = Ingredient(context: viewContext)
            newIngredient.name = alert.textFields![0].text!
            newIngredient.archived = false
            meal.addToIngredient(newIngredient)
            save()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
