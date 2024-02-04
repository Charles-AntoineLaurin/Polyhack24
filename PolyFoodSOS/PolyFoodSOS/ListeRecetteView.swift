//
//  ListeRecetteView.swift
//  PolyFoodSOS
//
//  Created by Charles-Antoine Laurin on 2024-02-03.
//

import SwiftUI
import Foundation
import Combine
import URLImage

struct Recipe: Decodable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}

struct RecipeResponse: Decodable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct ImageView: View {
    let imageUrl: String
    let width, height: CGFloat

    var body: some View {
        URLImage(URL(string:imageUrl)!) { proxy in
            proxy
                .resizable()
        }
        .frame(width: width, height: height) // Adjust the size as needed
    }
}


struct ListeRecetteView: View {
    @State private var showDetail: Bool = false
    @State private var data: [Recipe] = []

    var body: some View {
        List(data, id: \.id) { item in
            NavigationLink(destination: RecipeView(recipe_Id: item.id)){
                HStack {
                    ImageView(imageUrl: item.image, width:100, height:100)
                    Text(item.title)
                }
            }
        }.navigationBarBackButtonHidden()
        .onAppear(perform: loadData)
    }

        func loadData() {
            guard let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?diet=Gluten Free&apiKey=41060f320bce43e58f5908ffca8dde76") else {
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.data = decodedData.results
                        print(data)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }.resume()
        }
}

struct RecipeDetails: Decodable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes: Int
    let cookingMinutes: Int
    let aggregateLikes: Int
    let healthScore: Double
    let creditsText: String
    let license: String?
    let sourceName: String
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String
    let imageType: String
    let summary: String
    let dishTypes: [String]
    let winePairing: WinePairing
}

struct ExtendedIngredient: Decodable {
    let id: Int
    let aisle: String
    let image: String
    let consistency: String
    let name: String
    let nameClean: String
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

struct Measures: Decodable {
    let us: Measure
    let metric: Measure
}

struct Measure: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}


struct WinePairing: Decodable {
    let pairedWines: [String]
    let pairingText: String
    var productMatches: [ProductMatch] = []
}

struct ProductMatch: Decodable {}


struct RecipeView: View {
    var recipe_Id: Int
    @StateObject private var recipeDetails: RecipeDetailsViewModel
    
    init(recipe_Id: Int) {
        self.recipe_Id = recipe_Id
        self._recipeDetails = StateObject(wrappedValue: RecipeDetailsViewModel())
    }
    
    
    var body: some View {
        VStack {
            if let data = recipeDetails.data{
                VStack{
                    Text(data.title).font(.title)
                    ImageView(imageUrl: data.image, width: 200, height: 200)
                        .frame(width: 200, height: 200)
                    let text = data.summary
                    let replaced = text.replacingOccurrences(of: "<b>", with: " ")
                    let new_replaced = replaced.replacingOccurrences(of: "</b>", with: " ")
                    Text(new_replaced)
                    
                    Text("Ingredients: ")
                        .font(.subheadline)
                    ForEach(data.extendedIngredients, id: \.id) { ingredient in
                            HStack {
                                Text(ingredient.name).bold()
                                Text(String(ingredient.amount) + " " + ingredient.unit)
                            }
                    }
                }
            }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
            recipeDetails.loadData(recipeId: recipe_Id)
    }
}

class RecipeDetailsViewModel: ObservableObject {
    @Published var data: RecipeDetails?

    func loadData(recipeId: Int) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(recipeId)/information?includeNutrition=false&apiKey=41060f320bce43e58f5908ffca8dde76") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(RecipeDetails.self, from: data)
                DispatchQueue.main.async {
                    self.data = decodedData
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
}


#Preview {
    ListeRecetteView()
}
