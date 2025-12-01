//
//  ObjectifActivity.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//

import SwiftUI

struct ObjectifActivity: View {
    @Binding var sport: SportsEnum
    @Binding var objCal : Int
    @Binding var frequenceEntrainement: Int
    @Binding var trainingDuration: Int
    @Binding var timingObjSport: TimingEnum
    @Binding var minProgression: Int
    @Binding var timingProgression: TimingEnum
    var body: some View {
        VStack(spacing: 30){
            Text("Objectif d'activité physique")
                .bold()
            
            Picker( "sport", selection: $sport){
                ForEach(SportsEnum.allCases, id: \.self){ sport in
                    
                    Text(sport.rawValue)
                        
                    
                }
                
            }.tint(.text)
                .padding(8)
                .frame(width: 190)
                .background(.secondaire)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
            HStack{
                
                
                TextField("Objectif calorique", value: $objCal, format: .number)
                    .padding(8)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)
                
                Text("Kcal brûlées")
             
                
            }
            
            HStack{
                TextField("Objectif fréquence", value: $frequenceEntrainement, format: .number)
                    .padding(8)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)
                
                Text("entraînements de")
                
                TextField("durée entrainement", value: $trainingDuration, format: .number)
                    .padding(8)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)
                Text("min")
            }
            
            HStack{
                Spacer()
                Text("par")
                Picker( "Timing sport", selection: $timingObjSport){
                    ForEach(TimingEnum.allCases, id: \.self){ obj in
                        
                        Text(obj.rawValue)
                        
                        
                    }
                    
                }.tint(.text)
                    .padding(8)
                    .frame(width: 150)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                Spacer()
            }
            
            
            Text("Objectif d'activité physique")
                .bold()
            
            HStack {
                Text("Augmenter les séances de")
                TextField("Objectif calorique", value: $minProgression, format: .number)
                    .padding(8)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.text)
                Text("min")
            }
            
            HStack{
                Text("chaque")
                
                Picker( "Timing sport", selection: $timingProgression){
                    ForEach(TimingEnum.allCases, id: \.self){ obj in
                        
                        Text(obj.rawValue)
                        
                        
                    }
                    
                }.tint(.text)
                    .padding(8)
                    .frame(width: 150)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
            }
        }
        .padding(15)
        .background(.greenApp)
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .foregroundStyle(.backgroundApp)
    }
}

#Preview {
    ObjectifActivity(sport: .constant(.equitation), objCal: .constant(1500), frequenceEntrainement: .constant(7), trainingDuration: .constant(30), timingObjSport: .constant(.sixMois), minProgression: .constant(10), timingProgression: .constant(.unAn))
}
