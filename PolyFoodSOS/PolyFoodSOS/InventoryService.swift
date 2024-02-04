//
//  InventoryService.swift
//  PolyFoodSOS
//
//  Created by Richard Tham on 2024-02-03.
//

import Foundation
import SwiftUI

class InventoryService: ObservableObject {
    static let shared = InventoryService()
    private init() {}
    @Published public var ingredientList: [String] = ["apple"]
    public func addIngredient(input: String) {
        ingredientList.insert(input, at: 0)
    }
    public func getIngredientList() -> [String] {
        return ingredientList
    }
    public func removeIngredient(index: Int)-> Void {
        ingredientList.remove(at: index)
    }
}
