//
//  MealDetailView.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

struct MealDetailView: View {
    @Binding var meal : Meal
    @State var ingredientVM = IngredientViewModel()
    @Environment(MealViewModel.self) var mealVM
    @State var isShowingSheet = false
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack {
            Color.backgroundApp
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Text(meal.date.toDate() ?? Date(), style: .date)
                        .font(.custom("Quicksand", size: 24))
                        .bold()
                        .padding(.vertical)
                    
                    OneMealView(meal: $meal, bouton: false)
                        .padding(.bottom, 50)
                    
                    HStack{
                        Text("Ingredients")
                            .font(.custom("Quicksand", size: 24))
                            .bold()
                        
                        Spacer()
                        Button(action: {
                            isShowingSheet.toggle()
                        }, label: {
                            Text("ajouter")
                            
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                                .background(.greenApp)
                                .background(.greenApp.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                                .foregroundStyle(.backgroundApp)
                        })
                        
                    }
                    .padding(.bottom)
                    
                    if meal.ingredients.isEmpty{
                        Text("Tu n’as encore aucun ingrédient d’enregistré pour ton petit-déjeuner. Ajoutes-en dès mainenant  !")
                            .font(.callout)
                    }
                    else{
                        ForEach($meal.ingredients){ $ingredient in
                            
                            
                            OneIngredientView(ingredient: $ingredient)
                                .onChange(of: ingredient.quantity) { oldValue, newValue in
                                    Task {
                                        await ingredientVM.updateIngredientMealQuantity(
                                            mealId: meal.id,
                                            ingredientId: ingredient.id,
                                            quantity: ingredient.quantity ?? 1
                                        )
                                        if newValue == 0 {
                                            try? await Task.sleep(nanoseconds: 300_000_000)
                                            await reloadMeal()
                                        }
                                    }
                                }
                            
                        }
                        .id(meal.ingredients.count)
                    }
                    
                }
                .padding(.horizontal)
            }
            .sheet(isPresented: $isShowingSheet) {
                
                Task {
                    await reloadMeal()
                }
            } content: {
                AddIngredientView(showPupup: $isShowingSheet, meal: meal)
            }
            
            
        }
        .foregroundStyle(.text)
        .onDisappear{
            mealVM.fetchMeals(date: meal.date.toDate() ?? Date())
        }
    }
    
    private func reloadMeal() async {
        if let updatedMeal = await mealVM.fetchMealById(id: meal.id) {
            meal = updatedMeal
        }
    }
}

#Preview {
    MealDetailView(meal: .constant(Meal(id: UUID(), type: "", date: "", ingredients: [], totalCalories: 3, totalLipides: 3, totalProteines: 2, totalGlucides: 2))).environment(MealViewModel())
}
