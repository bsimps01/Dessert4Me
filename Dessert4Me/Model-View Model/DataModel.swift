//
//  DataModel.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import Foundation

struct Meal: Decodable {
    let strMeal: String // String for each meal
    let idMeal: String  // meal id
    let strMealThumb: String // meal image url
    
    var id: String { idMeal }  // Conform to Identifiable
}

struct MealResponse: Decodable {
    let meals: [Meal]  // List of Meals
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail] // Array of Dessert Details
}

struct MealDetail: Decodable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String?
    let strCategory: String?
    let strArea: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
}
