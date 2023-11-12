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
            List(viewModel.meals, id: \.idMeal) { meal in   // provides list of meals
                NavigationLink(destination: DessertDetailView(viewModel: viewModel, meal: meal)) { // navigates user to selected item
                    VStack {
                        Text(meal.strMeal)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if let image = viewModel.images[meal.idMeal] { // shows image for each item
                            Image(uiImage: image) // presents image
                                .resizable()
                                .scaledToFit()
                                .padding(.bottom, 25)
                        } else {
                            
                            if viewModel.isLoading {
                                LoadingView() // This will disappear when isLoading is false
                                    .frame(width: 100, height: 100)
                                    .padding(.bottom, 25)
                            }
                        }
                    }
                }
            }
                .navigationTitle("Desserts4Me")
                .onAppear {
                    viewModel.fetchDesserts() // fetches data for items in each cell
                }
            }
        }
    }

#Preview {
    ContentView()
}
