//
//  ObjectifCalView.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//

import SwiftUI

struct ObjectifCalView: View {
    @Binding var objCal: Int
    @Binding var objLipides: Int
    @Binding var objGlucides: Int
    @Binding var objProtein: Int
    var body: some View {
        VStack(spacing: 30){
            Text("Objectif calorique journalier")
                .bold()
            
            HStack{
                Spacer()
                Text("Atteindre")
                
                TextField("Objectif calorique", value: $objCal, format: .number)
                    .padding(8)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)
                
                Text("Kcal par jour")
                Spacer()
                
            }
            
            HStack(spacing: 30){
                VStack{
                    TextField("Objectif lipide", value: $objLipides, format: .number)
                        .padding(8)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                    
                    Text("g/jour\nlipides")
                        .multilineTextAlignment(.center)
                }
                VStack{
                    TextField("Objectif glucide", value: $objGlucides, format: .number)
                        .padding(8)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                    
                    Text("g/jour\nglucides")
                        .multilineTextAlignment(.center)
                }
                VStack{
                    TextField("Objectif lipide", value: $objProtein, format: .number)
                        .padding(8)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                    
                    Text("g/jour\nprotéines")
                        .multilineTextAlignment(.center)
                }
            }
            
        }
        .padding(15)
        .background(.greenApp)
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .foregroundStyle(.backgroundApp)
    }
}

#Preview {
    ObjectifCalView(objCal: .constant(1500), objLipides: .constant(70), objGlucides: .constant(200), objProtein: .constant(20))
}
