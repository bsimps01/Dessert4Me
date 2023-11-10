//
//  DataModel.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import Foundation

struct Meal: Decodable {
    let strMeal: String
    let idMeal: String
}

struct MealResponse: Decodable {
    let meals: [Meal]
}
