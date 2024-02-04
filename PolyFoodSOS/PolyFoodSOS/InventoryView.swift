//
//  InventoryView.swift
//  PolyFoodSOS
//
//  Created by Richard Tham on 2024-02-03.
//

import Foundation
import SwiftUI


struct InventoryView: View {
    @ObservedObject var inventoryService: InventoryService = InventoryService.shared
    @State private var ingredient: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("Ingredient", text: $ingredient).padding().cornerRadius(15).border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).padding(15).offset()
                Button("Add", action: {
                    inventoryService.addIngredient(input: ingredient)
                    
                    ingredient = ""
                }).padding()
            }
            Text("Ingredients :")
            ForEach(InventoryService.shared.getIngredientList(), id: \.self) { item in
                Text(item)
            }
            Spacer()
            
        }
    }
}
#Preview {
    InventoryView()
}
