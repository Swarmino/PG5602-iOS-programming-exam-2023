

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
            if meals.isEmpty {
                VStack{
                    Spacer()
                    Image(systemName: "square.stack.3d.up.slash")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                        .foregroundColor(.gray)
                    Text("Ingen matoppskrifter funnet")
                        .font(.subheadline)
                    Spacer()
                }.navigationTitle("Mine oppskrifter")
            } else {
                List {
                    ForEach(meals) { meal in
                        NavigationLink {
                            MealLocalDetailView(meal: meal)
                        } label: {
                            MealListView(meal: meal)
                        }
                    }
                }.navigationTitle("Mine oppskrifter")
            }
        }
    }
    
    struct MealListView: View {
        
        let meal: Meal
        
        let MealApi = MealAPI()
    
        @Environment(\.managedObjectContext) private var viewContext
        
        @State var image: UIImage?
        
        var body: some View {
            HStack{
                Image(systemName: meal.favourite ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 15, height: 15)
                ZStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                    Image(uiImage: image ?? UIImage(systemName: "carrot")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(100)
                        .onAppear {
                            MealApi.LoadImage(ImageUrl: meal.imageUrl!) { image in
                                self.image = image
                            }
                        }
                }
                VStack(alignment: .leading) {
                    Text("\(meal.name!)")
                    
                    if let categories = meal.category as? Set<Category>, let firstCategory = categories.first {
                        Text("\(firstCategory.name ?? "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        Text("No Category")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .swipeActions(edge: .trailing) {
                Button {
                    print("Archive meal")
                    ArchiveMeal(meal: meal)
                } label: {
                    Label("Archive", systemImage: "archivebox")
                }
                .tint(.red)
            }
            .swipeActions(edge: .leading) {
                if meal.favourite {
                    Button {
                        print("Unfavourite meal")
                        UnfavouriteMeal(meal: meal)
                    } label: {
                        Label("Unfavourite", systemImage: "star.slash")
                    }
                    .tint(.gray)
                } else {
                    Button {
                        print("Favourite meal")
                        FavouriteMeal(meal: meal)
                    } label: {
                        Label("Favourite", systemImage: "star")
                    }
                    .tint(.yellow)
                }
            }
        }
        
        private func ArchiveMeal(meal: Meal) {
            withAnimation {
                meal.archived = true
                UnfavouriteMeal(meal: meal)
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private func FavouriteMeal(meal: Meal) {
            withAnimation {
                meal.favourite = true
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
        
        private func UnfavouriteMeal(meal: Meal) {
            withAnimation {
                meal.favourite = false
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
    RecipeView()
}
