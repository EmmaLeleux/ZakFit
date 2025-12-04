//
//  ObjNutrimentDay.swift
//  ZakFit
//
//  Created by Emma on 03/12/2025.
//

import SwiftUI

struct ObjNutrimentDay: View {
    @Environment(MealViewModel.self) var mealVM
    var user: User
    var pourcent: Double {
        return (Double(mealVM.allMealsCalorie) / Double(user.calByDay)) * 100
    }
    var text : String{
        if pourcent < 15 {
            return "Mange un peu, tu es tout maigre"
        }
        else if pourcent < 50 {
            return "Tu es en bonne voie, courage !"
        }
        
        else if pourcent < 100 {
            return "Tu y es presque ! Encore un effort"
        }
        
        else{
            return "Tu es le boss !"
        }
    }
    var body: some View {
        VStack{
            if pourcent < 15 {
                
            }
            Text(text)
                .padding(.bottom)
            
            
            HStack{
                
                kcalByDayComponentView(progression: mealVM.allMealsCalorie, objectif: user.calByDay)
                Spacer()
                MacronutimentsComponentView(progression: mealVM.allMealsLipide, objectif: user.objLipides, typeNutriment: "lipides", color: .lipidesBlue)
                Spacer()
                MacronutimentsComponentView(progression: mealVM.allMealsProteine, objectif: user.objProtein, typeNutriment: "protéines", color: .proteinRed)
                Spacer()
                MacronutimentsComponentView(progression: mealVM.allMealsGlucide, objectif: user.objGlucides, typeNutriment: "glucides", color: .glucidePurple)
                
            }
        }
        .padding()
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
    }
}

#Preview {
    ObjNutrimentDay(user: User(id: UUID(), lastname: "", firstname: "", email: "", age: 4, profil_picture: "", weight: 4.5, height: 3, notifHour: "", typeWeightObj: "", sportObj: "", calburnobj: 3, timingCal: "", startDate: "", finalDate: "", timingTraining: "", nbTraining: 3, trainingDuration: 3, calByDay: 4, genre: "", objLipides: 3, objProtein: 3, objGlucides: 3, frequenceEntrainement: 3, minProgression: 3, timingProgression: "", isOnBoardCompleted: true)).environment(MealViewModel())
}
