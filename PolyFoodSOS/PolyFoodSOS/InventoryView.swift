//
//  InventoryView.swift
//  PolyFoodSOS
//
//  Created by Richard Tham on 2024-02-03.
//

import Foundation
import SwiftUI

struct InventoryView: View {
    @State private var ingredient: String = ""
    @State public var ingredientList: [String] = []
    var body: some View {
        VStack {
            HStack {
                TextField("Ingredient", text:$ingredient).padding().cornerRadius(15).border(Color.gray, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/).padding(15).offset().onChange(of: ingredient, perform: { newValue in
                    
                })
                Button("Add", action: {
                    ingredientList.insert(ingredient, at: 0)
                    ingredient = ""
                }).padding()
            }
            Text("Ingredients :")
            ForEach(ingredientList, id: \.self) { item in
                Text(item)
            }
            Spacer()
            
        }
        
    }
}
#Preview {
    InventoryView()
}
