//
//  MealViewModel.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import Foundation
import Observation

@Observable
class MealViewModel{
    var meals: [Meal] = []
    var mealCalories: Int = 0
    var mealLipides: Int = 0
    var mealProteines: Int = 0
    var mealGlucides: Int = 0
    var allMealsCalorie: Int {
        var sum: Int = 0
        for meal in meals {
            sum += meal.totalCalories
        }
        return sum
    }
    var allMealsLipide: Int {
        var sum: Int = 0
        for meal in meals {
            sum += meal.totalLipides
        }
        return sum
    }
    
    var allMealsGlucide: Int {
        var sum: Int = 0
        for meal in meals {
            sum += meal.totalGlucides
        }
        return sum
    }
    var allMealsProteine: Int {
        var sum: Int = 0
        for meal in meals {
            sum += meal.totalProteines
        }
        return sum
    }
    
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
    
    //récupère les repas selon un jor donné
    func fetchMeals(date: Date){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        guard let token,
              let url = URL(string: "http://localhost:8080/meal/date?date=\(dateString)") else {
            print("mauvais url")
            return }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do{
                    let decodedMeals = try JSONDecoder().decode([Meal].self, from: data)
                    DispatchQueue.main.async {
                        let repas = decodedMeals.sorted{ $0.getEnumType().ordre < $1.getEnumType().ordre }
                        self.meals = repas
                        
                    }
                }
                catch {
                    print("Error decoding: \(error)")
                    if let json = String(data: data, encoding: .utf8) {
                        print("Raw JSON:", json)
                    }
                }
            }
            else if let error {
                print("Error: \(error)")
            }
        }
        .resume()
    }
    
    
    //créait un nouveau repas que si il y a pas les 4 possibilités de déjà créées.
    func ensureFourMeals(for date: Date) async {
        print("entre dans la fonction")
        
        // Attendre que fetchMeals se termine
        await fetchMealsAsync(date: date)
        
        print("les meals sont fetch")
        
        let missing = MealEnum.allCases.filter { mealType in
            !self.meals.contains(where: { $0.type == mealType.rawValue })
        }
        
        print("il reste des meals manquants")
        print(missing)
        print(missing)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let mealDate = formatter.string(from: date)
        for meal in missing {
            
            await createMealAsync(with: CreateMeal(type: meal.rawValue, date: mealDate))
            print("et un meal créé")
        }
    }

    func fetchMealById(id: UUID) async -> Meal? {
        guard let token,
              let url = URL(string: "http://localhost:8080/meal/\(id)") else {
            print("mauvais url")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let meal = try decoder.decode(Meal.self, from: data)
            return meal
        } catch {
            print("Error fetching meal: \(error)")
            return nil
        }
    }
    
    // Version async de fetchMeals
    private func fetchMealsAsync(date: Date) async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        guard let token,
              let url = URL(string: "http://localhost:8080/meal/date?date=\(dateString)") else {
            print("mauvais url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedMeals = try decoder.decode([Meal].self, from: data)
            
            await MainActor.run {
                let repas = decodedMeals.sorted{ $0.getEnumType().ordre < $1.getEnumType().ordre }
                self.meals = repas
                
            }
        } catch {
            print("Error fetching meals: \(error)")
            if let data = try? await URLSession.shared.data(for: request).0,
               let json = String(data: data, encoding: .utf8) {
                print("Raw JSON:", json)
            }
        }
    }

    // Version async de createMeal
    private func createMealAsync(with fields: CreateMeal) async {
        guard let token = token else {
            print("mauvais token")
            return
        }
        
        guard let url = URL(string: "http://localhost:8080/meal") else {
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
            let newMeal = try decoder.decode(Meal.self, from: data)
            print("Meal créé avec succès: \(newMeal.id)")
        } catch {
            print("Erreur création meal:", error)
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
