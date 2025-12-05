//
//  MacroNutrimentHStack.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

struct MacroNutrimentHStack: View {
    var macroNutriment: String
    var quantity: Int
    var color: Color
    var body: some View {
        HStack{
            Circle().fill(color)
                .frame(width: 15, height: 15)
            Text("\(quantity)g \(macroNutriment)")
                .font(.system(size: 13))
                .bold()
        }
    }
}

#Preview {
    MacroNutrimentHStack(macroNutriment: "lipides", quantity: 9, color: .lipidesBlue)
}
