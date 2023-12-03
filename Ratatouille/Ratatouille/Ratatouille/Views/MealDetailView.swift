import SwiftUI

struct MealDetailView: View {
    
    let meal: MealData
    
    @State private var mealImage: UIImage? = nil
    @State private var flagImage: UIImage? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let uiImage = mealImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .foregroundColor(.gray)
                }
                
                Text(meal.strMeal)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Category: \(meal.strCategory)")
                    .font(.headline)
                
                HStack{
                    Text("Area: \(meal.strArea)")
                        .font(.headline)
                    Image(uiImage: flagImage ?? UIImage(systemName: "flag.slash")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                }.onAppear(){
                    FlagsAPI.getFlagImage(countryName: meal.strArea) { result in
                        switch result {
                        case .success(let image):
                            flagImage = image
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                
                Text("Ingredients:")
                    .font(.headline)
                
            }
            
            
            Text("Instructions:")
                .font(.headline)
            
            Text(meal.strInstructions)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .navigationTitle(meal.strMeal)
        .onAppear {
            loadImage(from: URL(string: meal.strMealThumb))
        }
    }
    
    public func loadImage(from url: URL?, completion: (() -> Void)? = nil) {
        guard let url = url else {
            completion?()
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.mealImage = uiImage
                    completion?()
                }
            } else {
                completion?()
            }
        }.resume()
    }
}
