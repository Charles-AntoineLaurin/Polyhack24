//
//  HomeView.swift
//  PolyFoodSOS
//
//  Created by Charles-Antoine Laurin on 2024-02-03.
//

import SwiftUI
import Foundation
import Combine
import URLImage


struct HomeView: View {
    var body: some View {
        VStack{
            NavigationLink(destination: ListeRecetteView()) {
                                Text("Liste de recette")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
            }
            NavigationLink(destination: InventoryView()) {
                                Text("Inventaire")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    HomeView()
}
