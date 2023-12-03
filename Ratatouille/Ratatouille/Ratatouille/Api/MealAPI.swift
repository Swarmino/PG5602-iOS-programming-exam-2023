import Foundation
import UIKit

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
                if let string = String(data: data, encoding: .utf8) {
                    print(string)
                }

                // Attempt to decode as MealResponse
                if let response = try? decoder.decode(MealResponse.self, from: data),
                   let meals = response.meals, !meals.isEmpty {
                    completion(.success(meals))
                } else {
                    // If decoding as MealResponse fails, attempt to decode as MealSimplifiedResponse
                    let simplifiedResponse = try decoder.decode(MealSimplifiedResponse.self, from: data)
                    
                    // Extract idMeal values
                    let idMeals = simplifiedResponse.meals?.compactMap { $0.idMeal } ?? []

                    // Use idMeals to fetch detailed information for each idMeal
                    let dispatchGroup = DispatchGroup()
                    var detailedMeals: [MealData] = []

                    for idMeal in idMeals {
                        dispatchGroup.enter()

                        self.fetchById(id: idMeal) { result in
                            switch result {
                            case .success(let detailedMeal):
                                detailedMeals.append(contentsOf: detailedMeal)
                            case .failure(let error):
                                print("Error fetching by id: \(error)")
                            }

                            dispatchGroup.leave()
                        }
                    }

                    dispatchGroup.notify(queue: .main) {
                        completion(.success(detailedMeals))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


    
    public func LoadImage(ImageUrl: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: ImageUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)
        }.resume()
    }

}

struct MealResponse: Codable {
    let meals: [MealData]?
}

struct MealSimplifiedResponse: Codable {
    let meals: [MealSimplifiedResponseObj]?
}

struct MealSimplifiedResponseObj: Codable, Identifiable {
    var id = UUID()
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidData
}
