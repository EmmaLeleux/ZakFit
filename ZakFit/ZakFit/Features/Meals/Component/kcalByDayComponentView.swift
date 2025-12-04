//
//  kcalByDayComponentView.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

struct kcalByDayComponentView: View {
    var progression : Int
    var objectif : Int
    var body: some View {
        VStack{
            ZStack {
                Circle()
                    .stroke(lineWidth: 15)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.orangeApp.opacity(0.5))
                
                Circle()
                    .trim(from: 0, to: CGFloat(progression * 100 / objectif)/100)
                    .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.orangeApp)
                    .rotationEffect(Angle(degrees: -90))
                
                VStack{
                    Text(progression.description)
                        .bold()
                        .font(.custom("Quicksand", size: 24))
                    Text("Kcal")
                }
            }
            .padding(.bottom)
            VStack{
                Text("Objectif")
                
                Text("\(objectif) Kcal")
                    .foregroundStyle(.orangeApp)
            }
            .bold()
        }
    }
}

#Preview {
    kcalByDayComponentView(progression: 9, objectif: 53)
}
