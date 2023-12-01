import Foundation

class MealAPI {
    static let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    public func fetchByName(name: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)search.php?s=\(name)"
        print("Fetching by name: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }
    
    public func fetchByCategory(category: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)filter.php?c=\(category)"
        print("Fetching by category: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }
    
    public func fetchByIngredient(ingredient: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)filter.php?i=\(ingredient)"
        print("Fetching by ingredient: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }
    
    public func fetchByArea(area: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)filter.php?a=\(area)"
        print("Fetching by area: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }
    
    public func fetchRandom(completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)random.php"
        print("Fetching random: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }

    
    public func fetchById(id: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
        let urlString = "\(MealAPI.baseURL)lookup.php?i=\(id)"
        print("Fetching by id: \(urlString)")
        fetchData(urlString: urlString, completion: completion)
    }
    
    private func fetchData(urlString: String, completion: @escaping (Result<[MealData], Error>) -> Void) {
       guard let url = URL(string: urlString) else {
           completion(.failure(NetworkError.invalidURL))
           return
       }

       URLSession.shared.dataTask(with: url) { (data, _, error) in
           if let error = error {
               completion(.failure(error))
               return
           }

           guard let data = data else {
               completion(.failure(NetworkError.invalidData))
               return
           }

           do {
               let decoder = JSONDecoder()
               decoder.keyDecodingStrategy = .convertFromSnakeCase
               let response = try decoder.decode(MealResponse.self, from: data)

               if let meals = response.meals, !meals.isEmpty {
                   completion(.success(meals))
               } else if let firstMeal = response.meals?.first {
                   self.fetchById(id: firstMeal.idMeal, completion: completion)
               } else {
                   completion(.failure(NetworkError.invalidData))
               }
           } catch {
               completion(.failure(error))
           }
       }.resume()
    }

}

struct MealResponse: Codable {
    let meals: [MealData]?
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
}
