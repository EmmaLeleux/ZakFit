//
//  MacronutimentsComponentView.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

struct MacronutimentsComponentView: View {
    var progression : Int
    var objectif : Int
    var typeNutriment: String
    var color: Color
    var pourcent: CGFloat {
        if objectif <= progression{
            return 100
        }
        
        else{
            return CGFloat(progression * 100 / objectif)
        }
    }
    var body: some View {
        VStack{
            
            ZStack{
                Capsule()
                    .frame(width: 15, height: 100)
                    .opacity(0.4)
                
                Capsule()
                    .frame(width: 15, height: pourcent)
                    .offset(y: (100 - pourcent) / 2)
                
                
            }
            .foregroundStyle(color)
            .padding(.bottom)
            Text("\(progression)/\(objectif)g")
            Text(typeNutriment)
                .bold()
        }
    }
}

#Preview {
    MacronutimentsComponentView(progression: 3, objectif: 60, typeNutriment: "lipides", color: .greenApp)
}
