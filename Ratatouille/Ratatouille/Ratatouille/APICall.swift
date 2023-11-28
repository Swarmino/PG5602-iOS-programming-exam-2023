import Foundation

struct MealAPI {
   static let baseURL = "https://www.themealdb.com/api/json/v1/1"
   
   static func searchMealByName(name: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
       let url = URL(string: "\(baseURL)/search.php?s=\(name)")!
   }
   
   static func fetchMealByCategory(category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
       let url = URL(string: "\(baseURL)/filter.php?c=\(category)")!
   }
   
   static func fetchMealByArea(area: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
       let url = URL(string: "\(baseURL)/filter.php?a=\(area)")!
   }
   
   static func fetchMealByIngredient(ingredient: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
       let url = URL(string: "\(baseURL)/filter.php?i=\(ingredient)")!
   }
   
}
