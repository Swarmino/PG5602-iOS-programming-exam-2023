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
                    .navigationTitle("Search")
                    .onAppear {
                        fetchData()
                    }
                Spacer()
                SearchBar(mealResults: $mealResults, searchResultsCache: searchResultsCache)
            }
        }
        .onDisappear {
            // Cache the results when the view disappears
            searchResultsCache.cacheResults(query: "", results: mealResults)
        }
    }
    
    private func fetchData() {
        if let cachedResults = searchResultsCache.getCachedResults(for: "") {
            // Use cached results if available
            mealResults = cachedResults
        } else {
            let api = MealAPI()
            api.fetchByName(name: "") { result in
                switch result {
                case .success(let meals):
                    mealResults = meals
                case .failure(let error):
                    print(error)
                }
            }
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
    
    var body: some View {
        if mealResults.isEmpty {
            Text("No results found")
        } else {
            List {
                ForEach(mealResults, id: \.idMeal) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealView(meal: meal)
                    }
                }
            }
        }
    }
}

struct MealView: View {
    let meal: MealData
    @State var mealImage: UIImage? = nil
    
    var body: some View {
        HStack {
            Image(uiImage: mealImage ?? UIImage(systemName: "photo")!)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(100)
            Text(meal.strMeal)
        }
        .onAppear {
            LoadImage(url: meal.strMealThumb)
        }
    }
    
    func LoadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.mealImage = UIImage(data: data)
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
