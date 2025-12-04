//
//  AddIngredientView.swift
//  ZakFit
//
//  Created by Emma on 03/12/2025.
//

import SwiftUI

struct AddIngredientView: View {
    @State var text: String = ""
    @State var ingredientsVM = IngredientViewModel()
    @Binding var showPupup: Bool
    var meal: Meal
    var body: some View {
        ZStack{
            Color.secondaire
                .ignoresSafeArea()
            NavigationStack{
                VStack{
                    TextField("", text: $text)
                        .padding()
                        .overlay(
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(lineWidth: 2).foregroundStyle(.greenApp)
                                HStack{
                                    Spacer()
                                    Image(.loupe)
                                        .padding(.trailing)
                                }
                            }
                        )
                    
                    
                    List(ingredientsVM.ingredients.filter { $0.name.lowercased().contains(text.lowercased()) }){ ingredient in
                        Button(action: {
                            let quantity = (ingredient.unit == "100g" ? 100 : 1)
                            Task{
                                await ingredientsVM.createIngredientMeal(with: CreateIngredientMeal(quantity: quantity, mealId: meal.id, ingredientId: ingredient.id))
                                showPupup.toggle()
                            }
                        }, label: {
                            Text(ingredient.name)
                                .foregroundStyle(.greenApp)
                        })
                        .listRowBackground(Color.backgroundApp)
                    }
                    .scrollContentBackground(.hidden)
                    
                    Text("Tu ne trouve pas ce que tu cherche ?")
                    
                    NavigationLink(destination: {
                        CreateIngredientView(showPupup: $showPupup, meal: meal)
                    }, label: {
                        Text("ajoute un ingrédient")
                            .padding()
                            .padding(.horizontal)
                            .background(.greenApp)
                            .background(.greenApp.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                            .foregroundStyle(.backgroundApp)
                            .bold()
                    })
                    
                    .task{
                        await ingredientsVM.getIngredients()
                    }
                }
                .padding()
            }
            
        }
    }
}

#Preview {
    AddIngredientView( showPupup: .constant(true), meal: Meal(id: UUID(), type: "", date: "", ingredients: [], totalCalories: 3, totalLipides: 3, totalProteines: 3, totalGlucides: 3))
}
