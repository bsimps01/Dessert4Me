//
//  DessertDetailView.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import SwiftUI

struct DessertDetailView: View {
    
    @ObservedObject var viewModel: Dessert4MeViewModel
    
    @State private var showingModal = false
    @State private var mealDetail: MealDetailResponse?
    
    @StateObject private var imageLoader: DetailImage
    
    var meal: Meal
    
    // intializer
    init(viewModel: Dessert4MeViewModel, meal: Meal) {
        self.viewModel = viewModel
        self.meal = meal
        _imageLoader = StateObject(wrappedValue: DetailImage(urlString: meal.strMealThumb))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let mealDetail = mealDetail { // accesses data from dessert detail
                    
                    Text(mealDetail.meals[0].strMeal) // Dessert name
                        .font(.title)
                    
                    if let image = imageLoader.image { // Dessert image
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 25)
                    }
                }
                
                // Category and Origin
                Group {
                    Text("Category: \(mealDetail?.meals[0].strCategory ?? "Category not Listed")") // Dessert Category
                    Text("Origin: \(mealDetail?.meals[0].strArea ?? "Area not Listed")") // Dessert Area
                        .padding(.bottom, 25)
                }

                // Ingredients
                let ingredientList = getIngredientList(from: mealDetail)
                Text("Ingredients")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                ForEach(ingredientList, id: \.self) { ingredient in //Each ingredient in the list
                    Text(ingredient)
                }
                .padding(.bottom, 25)

                // Instructions
                Text("Instructions")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                if let instructions = mealDetail?.meals[0].strInstructions {
                    let steps = instructions.split(separator: "\n").map(String.init) // Each instruction separated by line break
                    ForEach(steps, id: \.self) { step in
                        Text(step)
                    }
                    .padding(.bottom)
                } else {
                    Text("No Instructions").padding()
                }
                
                Button("Watch How to Make on YouTube") { // Button that takes user to a modal showcasing youtube video
                    showingModal = true
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .sheet(isPresented: $showingModal) {
                    if let youtubeLink = mealDetail?.meals[0].strYoutube { // accesses webview via youtube link
                        WebView(urlString: youtubeLink)
                    }
                }
            }
            .padding()
        }
            .onAppear {
                viewModel.fetchMealDetails(id: meal.idMeal) { fetchedDetails in
                    mealDetail = fetchedDetails
                }
            }
        }
    
    func getIngredientList(from response: MealDetailResponse?) -> [String] {
        guard let mealDetail = response?.meals.first else { return [] }
        
        // List of all possible options for ingredients and measurements
        let ingredients = [
            (mealDetail.strIngredient1, mealDetail.strMeasure1),
            (mealDetail.strIngredient2, mealDetail.strMeasure2),
            (mealDetail.strIngredient3, mealDetail.strMeasure3),
            (mealDetail.strIngredient4, mealDetail.strMeasure4),
            (mealDetail.strIngredient5, mealDetail.strMeasure5),
            (mealDetail.strIngredient6, mealDetail.strMeasure6),
            (mealDetail.strIngredient7, mealDetail.strMeasure7),
            (mealDetail.strIngredient8, mealDetail.strMeasure8),
            (mealDetail.strIngredient9, mealDetail.strMeasure9),
            (mealDetail.strIngredient10, mealDetail.strMeasure10),
            (mealDetail.strIngredient11, mealDetail.strMeasure11),
            (mealDetail.strIngredient12, mealDetail.strMeasure12),
            (mealDetail.strIngredient13, mealDetail.strMeasure13),
            (mealDetail.strIngredient14, mealDetail.strMeasure14),
            (mealDetail.strIngredient15, mealDetail.strMeasure15),
            (mealDetail.strIngredient16, mealDetail.strMeasure16),
            (mealDetail.strIngredient17, mealDetail.strMeasure17),
            (mealDetail.strIngredient18, mealDetail.strMeasure18),
            (mealDetail.strIngredient19, mealDetail.strMeasure19),
            (mealDetail.strIngredient20, mealDetail.strMeasure20)
        ]
        
        return ingredients.compactMap { ingredient, measure in
            guard let ingredient = ingredient, !ingredient.isEmpty else { return nil }
            return "\(ingredient): \(measure ?? "")"
        }
    }

    }


//#Preview {
//    DessertDetailView(viewModel: Dessert4MeViewModel, meal: Meal)
//}
