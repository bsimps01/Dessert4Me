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
                    }
                }
            }
        }.resume()
    }
}
