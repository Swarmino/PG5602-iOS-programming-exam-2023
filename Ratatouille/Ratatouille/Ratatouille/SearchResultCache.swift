
import Foundation

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
