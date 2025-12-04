//
//  OneMealView.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

struct OneMealView: View {
    @Binding var meal: Meal
    @Environment(MealViewModel.self) var mealVM
    var bouton: Bool = true
    var calories : Int {
        meal.ingredients.reduce(0) { total, ingredient in
                    total + (ingredient.cal * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1))
                }
    }
    var lipides : Int {
        meal.ingredients.reduce(0) { total, ingredient in
            total + (ingredient.carbonhydrate * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1))
                }
    }
    var protein : Int {
        meal.ingredients.reduce(0) { total, ingredient in
            total + (ingredient.protein * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1))
                }
    }
    var glucides : Int {
        meal.ingredients.reduce(0) { total, ingredient in
            total + (ingredient.glucide * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1))
                }
    }
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Image(meal.getEnumType().image)
                }
                .frame(width: 62, height: 59)
                Text(meal.getEnumType().rawValue)
                    .font(.custom("Quicksand", size: 16))
                
                Spacer()
                Text("\(calories) Kcal")
                
                    .padding(.trailing, 5)
                if bouton{
                NavigationLink(destination: {
                    MealDetailView(meal: $meal)
                }, label: {
                    Text(calories == 0 ? "ajouter" : "détails")
                    
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(.greenApp)
                        .background(.greenApp.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .foregroundStyle(.backgroundApp)
                })
            }
            }
            .font(.system(size: 14))
            .bold()
            HStack{
                MacroNutrimentHStack(macroNutriment: "lipides", quantity: lipides, color: .lipidesBlue)
                Spacer()
                MacroNutrimentHStack(macroNutriment: "protéines", quantity: protein, color: .proteinRed)
                Spacer()
                MacroNutrimentHStack(macroNutriment: "glucides", quantity: glucides, color: .glucidePurple)
            }
        }
        .padding()
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
        
    }
}

#Preview {
    OneMealView(meal: .constant(Meal(id: UUID(), type: "", date: "", ingredients: [], totalCalories: 4, totalLipides: 3, totalProteines: 2, totalGlucides: 3))).environment(MealViewModel())
}
