import Foundation
import SwiftUI

class SearchResultsCache: ObservableObject {
    static let shared = SearchResultsCache()
    
    @Published var cachedResults: [String: [MealData]] = [:]
    
    private init() {}
    
    func cacheResults(query: String, results: [MealData]) {
        DispatchQueue.main.async {
            self.cachedResults[query] = results
        }
    }
    
    func getCachedResults(for query: String) -> [MealData]? {
        return cachedResults[query]
    }
}


struct SearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var searchResultsCache = SearchResultsCache.shared
    
    @State private var mealResults: [MealData] = []
    @State private var resultFound: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ResultView(mealResults: $mealResults)
                    .navigationTitle("Søk")
                Spacer()
                SearchBar(mealResults: $mealResults, searchResultsCache: searchResultsCache)
            }
        }
        .onDisappear {
            searchResultsCache.cacheResults(query: "", results: mealResults)
        }
    }
}

struct SearchBar: View {
    @State private var searchText: String = ""
    @Binding var mealResults: [MealData]
    @ObservedObject var searchResultsCache: SearchResultsCache
    
    enum Category: String, CaseIterable, Identifiable {
        case Navn, Ingredienser, Område, Kategori
        var id: Self { self }
    }
    
    @State private var selectedCategory: Category = .Navn
    
    var body: some View {
        VStack {
            Picker(selection: $selectedCategory, label: Text("picker")) {
                ForEach(Category.allCases) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            HStack {
                TextField("Search", text: $searchText)
                    .padding()
                Button(action: {
                    handleSearch()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .padding()
                })
            }
        }
    }
    
    private func handleSearch() {
        let api = MealAPI()
        switch selectedCategory {
        case .Navn:
            api.fetchByName(name: searchText) { result in
                switch result {
                case .success(let meals):
                    mealResults = meals
                    searchResultsCache.cacheResults(query: searchText, results: meals)
                case .failure(let error):
                    mealResults = []
                    print(error)
                }
            }
        case .Ingredienser:
            api.fetchByIngredient(ingredient: searchText) { result in
                switch result {
                case .success(let meals):
                    mealResults = meals
                    searchResultsCache.cacheResults(query: searchText, results: meals)
                case .failure(let error):
                    mealResults = []
                    print(error)
                }
            }
        case .Område:
            api.fetchByArea(area: searchText) { result in
                switch result {
                case .success(let meals):
                    mealResults = meals
                    searchResultsCache.cacheResults(query: searchText, results: meals)
                case .failure(let error):
                    mealResults = []
                    print(error)
                }
            }
        case .Kategori:
            api.fetchByCategory(category: searchText) { result in
                switch result {
                case .success(let meals):
                    mealResults = meals
                    searchResultsCache.cacheResults(query: searchText, results: meals)
                case .failure(let error):
                    mealResults = []
                    print(error)
                }
            }
        }
    }
}

struct ResultView: View {
    @Binding var mealResults: [MealData]
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        if mealResults.isEmpty {
            Spacer()
            Image(systemName: "questionmark.folder")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.ratBlue)
                .padding()
            Text("No results found")
            Spacer()
        } else {
            List {
                ForEach(mealResults, id: \.idMeal) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealView(meal: meal)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            AddMealToCD(meal: meal)
                        } label: {
                            Label("Add to device", systemImage: "square.and.arrow.down.fill")
                        }
                        .tint(.green)
                    }
                }
            }
        }
    }
    
    func AddMealToCD(meal: MealData) {
        let newMeal = Meal(context: viewContext)
        newMeal.name = meal.strMeal
        newMeal.archived = false
        newMeal.favourite = false
        newMeal.instructions = meal.strInstructions
        newMeal.imageUrl = meal.strMealThumb
        newMeal.id = UUID()
        
        let newCategory = Category(context: viewContext)
        newCategory.name = meal.strCategory
        newCategory.archived = false
        newMeal.addToCategory(newCategory)
        
        let newArea = Area(context: viewContext)
        newArea.name = meal.strArea
        newArea.archived = false
        newMeal.addToArea(newArea)
        
        let newIngredient = Ingredient(context: viewContext)
        newIngredient.name = meal.strIngredient1
        newIngredient.archived = false
        newMeal.addToIngredient(newIngredient)
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MealView: View {
    let meal: MealData
    @State var mealImage: UIImage? = nil
    
    var MealApi = MealAPI()
    
    var body: some View {
        HStack {
            Image(uiImage: mealImage ?? UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(100)
            VStack(alignment: .leading) {
                Text(meal.strMeal)
                Text(meal.strCategory)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            MealApi.LoadImage(ImageUrl: meal.strMealThumb) { image in
                self.mealImage = image
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
