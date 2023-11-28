import Foundation
import CoreData

struct MealAPI {
 static let baseURL = "https://www.themealdb.com/api/json/v1/1"

 static func parseJSON(jsonString: String) -> [String: Any]? {
     let jsonData = jsonString.data(using: .utf8)!
     let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: [])
     return jsonObject as? [String: Any]
 }
    
    
}
