//
//  OneIngredientView.swift
//  ZakFit
//
//  Created by Emma on 03/12/2025.
//

import SwiftUI

struct OneIngredientView: View {
    @Binding var ingredient: Ingredient
    var lipides: Int {
        ingredient.carbonhydrate * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1)
    }
    var glucides: Int {
        ingredient.glucide * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1)
    }
    var protein: Int {
        ingredient.protein * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1)
    }
    var calories: Int {
        ingredient.cal * (ingredient.quantity ?? 0) / (ingredient.unit == "100g" ? 100 : 1)
    }
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        ZStack {
            
            VStack{
                
                
                HStack{
                    
                    Text(ingredient.name)
                        .frame(width: 90, alignment: .leading)
                    Spacer()
                    HStack{
                        Button(action: {
                            if ingredient.quantity ?? 0 > 0{
                                ingredient.quantity! -= 1
                            }
                            
                        }, label: {
                            Image(systemName: "minus")
                                .foregroundStyle(.greenApp)
                                .padding(.vertical)
                        })
                        
                        TextField("", value: $ingredient.quantity, format: .number)
                            .frame(maxWidth: 50)
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                isFocused.toggle()
                            }
                        
                        
                        Button(action: {
                            if ingredient.quantity ?? 9999 < 9999{
                                ingredient.quantity! += 1
                            }
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.greenApp)
                                .padding(.vertical)
                        })
                        
                        Text("\(ingredient.unit == "100g" ? "g" : ingredient.unit)\(ingredient.quantity! > 1 && ingredient.unit != "100g" ? "s" : "")")
                            
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    
                    Text("\(calories) Kcal")
                    
                }
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
        }.onTapGesture{
            isFocused = false
        }
        
    }
}

#Preview {
    OneIngredientView(ingredient: .constant(Ingredient(id: UUID(), name: "test", cal: 4, carbonhydrate: 4, protein: 4, glucide: 4, unit: "100g", quantity: 3)))
}
