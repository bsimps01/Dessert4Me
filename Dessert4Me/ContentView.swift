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
                Text(meal.strMeal)
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
