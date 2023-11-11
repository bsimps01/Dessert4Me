//
//  ContentView.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = Dessert4MeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals, id: \.idMeal) { meal in
                VStack {
                    Text(meal.strMeal)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let image = viewModel.images[meal.idMeal] {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 25)
                    } else {
                        Rectangle().foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Desserts4Me")
            .onAppear {
                viewModel.fetchDesserts()
            }
        }
    }
}

#Preview {
    ContentView()
}
