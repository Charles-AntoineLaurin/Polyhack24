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
    @State private var showModification: Bool = false
    
    var body: some View {
        NavigationStack{
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
                Button("Modify"){
                    showModification = true
                }
            }.navigationDestination(isPresented: $showModification) {
                ModifyListView()
            }

        }
    }
}

struct ModifyListView: View {
    @ObservedObject var inventoryService: InventoryService = InventoryService.shared
    @State private var showModification: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                ForEach(Array(inventoryService.getIngredientList().enumerated()), id: \.offset) { index, element in
                    HStack{
                        Text(element)
                        Button(action: {
                            inventoryService.removeIngredient(index: index)
                        }) {
                            Image(systemName: "trash")
                                .renderingMode(.original)
                        }
                    }
                }
                Spacer()
                Button("Save"){
                    showModification = true
                }
            }.navigationDestination(isPresented: $showModification) {
                InventoryView()
            }
        }
    }
}

#Preview {
    InventoryView()
}
