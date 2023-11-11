//
//  ViewModel.swift
//  Dessert4Me
//
//  Created by Benjamin Simpson on 11/10/23.
//

import SwiftUI
import Combine

class Dessert4MeViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var images: [String: UIImage] = [:]

    
    func fetchDesserts() {
        isLoading = true
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                        self?.meals = decodedResponse.meals
                        self?.meals.forEach { self?.loadImage(for: $0)}
                    }
                }
            }
        }.resume()
    }
    
    func loadImage(for meal: Meal) {
        guard let url = URL(string: meal.strMealThumb) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self?.images[meal.idMeal] = image
                }
            }
        }.resume()
    }
}
