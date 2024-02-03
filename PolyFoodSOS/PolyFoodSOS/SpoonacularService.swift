//
//  SpoonacularService.swift
//  PolyFoodSOS
//
//  Created by Richard Tham on 2024-02-03.
//
struct Ingredient: Decodable {
    let name: String
    let image: String
}

import Foundation

class SpoonacularService {
    static let shared = SpoonacularService()
    let key: String = "?apiKey=fe1de0baec39476fa3874e5cb92440e2"
    private var data: [Ingredient] = []
    private init() {}
    private final var number: Int = 4
    private var addr: String = "https://api.spoonacular.com/food/ingredients/autocomplete"
    func autoComplete (input: String) {
        let path = "\(addr)\(key)&query=\(input)&number=\(number)"
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Ingredient].self, from: data)
                DispatchQueue.main.async {
                    self.data = decodedData
                    print(self.data)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
            
        }.resume()
        
    }
}
