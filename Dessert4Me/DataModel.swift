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
    let meals: [Meal]
}
