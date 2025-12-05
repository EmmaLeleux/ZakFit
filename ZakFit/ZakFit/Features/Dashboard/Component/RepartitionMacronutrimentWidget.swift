//
//  RepartitionMacronutrimentWidget.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct RepartitionMacronutrimentWidget: View {
    @Environment(MealViewModel.self) var mealVM
    
    var total: Int{
        let res = mealVM.allMealsGlucide + mealVM.allMealsLipide + mealVM.allMealsProteine
        
        if res == 0{
            return 10
        }
        return res
    }
    var pourcentLipides : Double{
        Double(mealVM.allMealsLipide / total)
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text("Répartition des\nmacronutriments")
                .font(.custom("Quicksand", size: 16))
                .bold()
                .foregroundStyle(.greenApp)
                .padding(.bottom)
            
            if mealVM.allMealsLipide != 0 || mealVM.allMealsProteine != 0 || mealVM.allMealsGlucide != 0{
                
                
                ZStack {
                    Circle()
                        .stroke(lineWidth: 15)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.glucidePurple)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(Double(mealVM.allMealsProteine) / Double(total)))
                        .stroke(lineWidth: 15)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.proteinRed)
                        .rotationEffect(Angle(degrees: -90))
                    
                    Circle()
                        .trim(from:
                                0, to: CGFloat(Double(mealVM.allMealsLipide) / Double(total)))
                        .stroke(lineWidth: 15)
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.lipidesBlue)
                        .rotationEffect(Angle(degrees: (-90 + (Double(mealVM.allMealsProteine) / Double(total)) * 360)))
                }
                .padding()
                
                
                VStack(alignment: .leading){
                    MacroNutrimentHStack(macroNutriment: "lipides", quantity: mealVM.allMealsLipide, color: .lipidesBlue)
                    
                    MacroNutrimentHStack(macroNutriment: "protéines", quantity: mealVM.allMealsProteine, color: .proteinRed)
                    
                    MacroNutrimentHStack(macroNutriment: "glucides", quantity: mealVM.allMealsGlucide, color: .glucidePurple)
                }
            }
            
            else{
                Text("Tu n'a encore rien\nmangé aujourd'hui.")
                    .font(.callout)
            }
        }
        .padding()
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
        .task{
            mealVM.fetchMeals(date: Date())
        }
    }
}

#Preview {
    RepartitionMacronutrimentWidget().environment(MealViewModel())
}
