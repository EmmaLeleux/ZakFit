//
//  IngredientViewModel.swift
//  ZakFit
//
//  Created by Emma on 03/12/2025.
//

import Foundation
import Observation

@Observable
class IngredientViewModel{
    var ingredients : [Ingredient] = []
    
    var name: String = ""
    var unitType : UnitEnum = .gramme
    var unite: String = ""
    var calories: Int = 0
    var lipides: Int = 0
    var glucides: Int = 0
   var protein: Int = 0
    
    var ingredient: Ingredient? = nil
    
    
    var token: String? {
        didSet {
            if let token {
                saveToken(token)
            } else {
                clearToken()
            }
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(onLogin), name: .didLogin, object: nil)
        self.token = loadToken()
    }

    @objc private func onLogin() {
        
        self.token = loadToken()
    }
    
    
    func updateIngredientMealQuantity(mealId: UUID, ingredientId: UUID, quantity: Int) async {
        guard let token = token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/ingredient-meal/\(mealId)/ingredient/\(ingredientId)") else {
            print("mauvais URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(["quandtity" : quantity])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("Erreur update:", error)
                return
            }
            
        }.resume()
    }
    
    
    func createIngredient(with fields: CreateIngredient) async {
        guard let token = token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/ingredient") else {
            print("mauvais URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(fields)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let newIngredient = try decoder.decode(Ingredient.self, from: data)
            print("Ingredient créé avec succès: \(newIngredient.id)")
            DispatchQueue.main.async {
                self.ingredient = newIngredient
                
            }
            await getIngredients()
        } catch {
            print("Erreur création meal:", error)
        }
    }
    
    func createIngredientMeal(with fields: CreateIngredientMeal) async {
        guard let token = token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/ingredient-meal") else {
            print("mauvais URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.httpBody = try? encoder.encode(fields)
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
        } catch {
            print("Erreur création meal:", error)
        }
    }
    
    
    func getIngredients() async{
        guard let token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/ingredient") else {
            print("mauvais url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedMeals = try decoder.decode([Ingredient].self, from: data)
            
            await MainActor.run {
                let listIngredients = decodedMeals.sorted{ $0.name < $1.name }
                self.ingredients = listIngredients
                print(ingredients)
                
            }
        } catch {
            print("Error fetching meals: \(error)")
            if let data = try? await URLSession.shared.data(for: request).0,
               let json = String(data: data, encoding: .utf8) {
                print("Raw JSON:", json)
            }
        }
    }
    
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "authToken")
    }
    
    private func loadToken() -> String? {
        
        UserDefaults.standard.string(forKey: "authToken")
    }
    
    private func clearToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")
    }
}

