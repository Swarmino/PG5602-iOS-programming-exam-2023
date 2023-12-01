import Foundation
import UIKit

class FlagsAPI {
    static let baseURL = "https://flagsapi.com/"

    enum Style: String {
        case flat = "flat"
        case shiny = "shiny"
    }

    enum Size: String {
        case small = "32"
        case medium = "64"
        case large = "128"
    }

    private static let countryMapping: [String: String] = [
        "American": "US",
        "British": "GB",
        "Canadian": "CA",
        "Chinese": "CN",
        "Croatian": "HR",
        "Dutch": "NL",
        "Egyptian": "EG",
        "Filipino": "PH",
        "French": "FR",
        "Greek": "GR",
        "Indian": "IN",
        "Irish": "IE",
        "Italian": "IT",
        "Jamaican": "JM",
        "Japanese": "JP",
        "Kenyan": "KE",
        "Malaysian": "MY",
        "Mexican": "MX",
        "Moroccan": "MA",
        "Polish": "PL",
        "Portuguese": "PT",
        "Russian": "RU",
        "Spanish": "ES",
        "Thai": "TH",
        "Tunisian": "TN",
        "Turkish": "TR",
        "Unknown": "unknown",
        "Vietnamese": "VN"
    ]


    static func getFlagURL(countryName: String, style: Style = .flat, size: Size = .medium) -> URL? {
        guard let countryCode = countryMapping[countryName] else {
            print("Country code not found for \(countryName)")
            return nil
        }

        let urlString = "\(baseURL)\(countryCode)/\(style.rawValue)/\(size.rawValue).png"
        return URL(string: urlString)
    }

    static func getFlagImage(countryName: String, style: Style = .flat, size: Size = .medium, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = getFlagURL(countryName: countryName, style: style, size: size) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(NetworkError.invalidData))
                return
            }

            completion(.success(image))
        }.resume()
    }
}
