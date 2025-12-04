//
//  Ingredient.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import Foundation

struct Ingredient: Identifiable, Codable {
    var id: UUID
    var name: String
    var cal: Int
    var carbonhydrate: Int
    var protein: Int
    var glucide: Int
    var unit: String
    var quantity: Int?
}


struct CreateIngredient: Codable {
    var name : String
    var cal : Int
    var carbonhydrate : Int
    var protein: Int
    var glucide: Int
    var unit : String
}

struct CreateIngredientMeal: Codable{
    var quantity: Int
    var mealId: UUID
    var ingredientId: UUID
}
