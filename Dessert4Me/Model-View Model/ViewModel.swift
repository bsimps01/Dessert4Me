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
    @Published var images: [String: UIImage] = [:]
    @Published var isLoading = false

    // Fetch all the Desserts
    func fetchDesserts() {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid url")
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    // Optionally set a default image in case of error
                    return
                }
                // Parse through the data
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                        self?.meals = decodedResponse.meals
                        self?.meals.forEach { self?.loadImage(for: $0)}
                    }
                }
                self?.isLoading = false
            }
        }.resume()
    }
    
    // Load the item's image
    func loadImage(for meal: Meal) {
        guard let url = URL(string: meal.strMealThumb) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                
                //check for errors
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                    // Optionally set a default image in case of error
                    return
                }
                    //parsse through the data
                if let data = data, let image = UIImage(data: data) {
                    self?.images[meal.idMeal] = image
                } else {
                    print("Unable to load image.")
                    // Optionally set a default image in case of failure
                }
            }
        }.resume()
    }

    
    // Fetch the Details of each specific meal
    func fetchMealDetails(id: String, completion: @escaping (MealDetailResponse?) -> Void) {
        
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // check for errors
                if let error = error {
                    print("Fetch failed: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
            // see if the data is valid
                guard let data = data else {
                    print("No data received")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
            // parse through the data
                do {
                    let mealDetails = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(mealDetails)
                    }
                } catch {
                    print("JSON Decoding Error: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
    }
}
