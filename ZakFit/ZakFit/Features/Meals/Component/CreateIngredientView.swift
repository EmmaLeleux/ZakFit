//
//  CreateIngredientView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct CreateIngredientView: View {
    @FocusState var isFocused: Bool
    @State var ingredientVM = IngredientViewModel()
    @Binding var showPupup: Bool
    var meal: Meal
    var body: some View {
        ZStack{
            Color.backgroundApp.ignoresSafeArea()
            
            VStack{
                Text("Ajouter un ingrédient")
                    .font(.custom("Quicksand", size: 32))
                    .bold()
                    .padding(.bottom)
                
                TextFieldComponentView(placeholder: "Nom de l'ingrédient", text: $ingredientVM.name)
            
                HStack{
                    Picker("Unité de mesure", selection: $ingredientVM.unitType){
                        Text("gramme").tag(UnitEnum.gramme)
                        Text("personalisé").tag(UnitEnum.personnalise)
                    }
                    .tint(.greenApp)
                    .padding(10)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                   
                    Spacer()
                    
                    if ingredientVM.unitType == .personnalise{
                        TextFieldComponentView(placeholder: "unité de mesure", text: $ingredientVM.unite)
                            .autocapitalization(.none)
                    }
                    
                }
                .padding(.vertical)
                
                HStack{
                       
                    TextField("age", value: $ingredientVM.calories , format: .number)
                        .padding()
                        .frame(width: 100)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    
                    Spacer()
                    
                    Text("Calories pour \(ingredientVM.unitType == .gramme ? "100g" : "1 \(ingredientVM.unite)")")
                        .padding(.leading)
                    
                }
                
                HStack{
                       
                    TextField("age", value: $ingredientVM.lipides , format: .number)
                        .padding()
                        .frame(width: 100)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    
                    Spacer()
                    
                    Text("Lipides pour \(ingredientVM.unitType == .gramme ? "100g" : "1 \(ingredientVM.unite)")")
                        .padding(.leading)
                    
                }
                
                HStack{
                       
                    TextField("age", value: $ingredientVM.protein , format: .number)
                        .padding()
                        .frame(width: 100)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    
                    Spacer()
                    
                    Text("Protéines pour \(ingredientVM.unitType == .gramme ? "100g" : "1 \(ingredientVM.unite)")")
                        .padding(.leading)
                    
                }
                
                HStack{
                       
                    TextField("age", value: $ingredientVM.glucides , format: .number)
                        .padding()
                        .frame(width: 100)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    
                    Spacer()
                    
                    Text("Glucides pour \(ingredientVM.unitType == .gramme ? "100g" : "1 \(ingredientVM.unite)")")
                        .padding(.leading)
                    
                }
                    
                Button(action: {
                    Task{
                        let quantity = ingredientVM.unitType == .gramme ? 100 : 1
                        await ingredientVM.createIngredient(with: CreateIngredient(name: ingredientVM.name, cal: ingredientVM.calories, carbonhydrate: ingredientVM.lipides, protein: ingredientVM.protein, glucide: ingredientVM.glucides, unit: (ingredientVM.unitType == .gramme ? "100g" : ingredientVM.unite)))
                        
                        sleep(1)
                        
                        await ingredientVM.createIngredientMeal(with: CreateIngredientMeal(quantity: quantity, mealId: meal.id, ingredientId: ingredientVM.ingredient?.id ?? UUID()))
                        showPupup.toggle()
                    }
                }, label: {
                    Text("Enregistrer")
                        .padding()
                        .frame(width: 200)
                        .background(.greenApp)
                        .foregroundStyle(.backgroundApp)
                        .clipShape(Capsule())
                        .bold()
                })
                .padding()
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CreateIngredientView(showPupup: .constant(true), meal: Meal(id: UUID(), type: "", date: "", ingredients: [], totalCalories: 3, totalLipides: 3, totalProteines: 3, totalGlucides: 3))
}
