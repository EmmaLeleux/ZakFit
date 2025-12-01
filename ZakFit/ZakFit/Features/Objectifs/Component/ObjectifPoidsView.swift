//
//  ObjectifPoidsView.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//

import SwiftUI

struct ObjectifPoidsView: View {
    @Binding var objectifPoid: WeightObjectifsEnum
    @Binding var nbKilo: Double
    @Binding var timingObjPoid: TimingEnum
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Objectif de poids")
                    .bold()
                
                Picker( "poids", selection: $objectifPoid){
                    ForEach(WeightObjectifsEnum.allCases, id: \.self){ obj in
                        
                        Text(obj.rawValue)
                            
                        
                    }
                    
                }.tint(.text)
                    .padding(8)
                    .frame(width: 190)
                    .background(.secondaire)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                
               Spacer()
            }
            
            if objectifPoid != .maintainWeight{
                
                HStack{
                    Text(objectifPoid == .loseWeight ? "Perdre" : "Gagner")
                    
                    TextField("Nombre de kilos", value: $nbKilo, format: .number)
                        .padding(8)
                        .background(.secondaire)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.text)
                    
                    Text("Kg en")
                    
                    Picker( "Timing poids", selection: $timingObjPoid){
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
        }
        .padding(15)
        .background(.greenApp)
        .clipShape(RoundedRectangle(cornerRadius: 35))
        .foregroundStyle(.backgroundApp)
    }
}

#Preview {
    ObjectifPoidsView(objectifPoid: .constant(.gainWeight), nbKilo: .constant(32), timingObjPoid: .constant(.troisMois))
}
