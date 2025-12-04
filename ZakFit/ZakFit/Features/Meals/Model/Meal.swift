//
//  Meal.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import Foundation

struct Meal: Identifiable, Codable{
    var id: UUID
    var type: String
    var date: String
    var ingredients: [Ingredient]
    var totalCalories: Int
    var totalLipides: Int
    var totalProteines: Int
    var totalGlucides: Int
    
    
    func getEnumType() -> MealEnum{
        return MealEnum(rawValue: type) ?? .breakfast
    }
}


struct CreateMeal: Codable{
    var type: String
    var date: String
}
