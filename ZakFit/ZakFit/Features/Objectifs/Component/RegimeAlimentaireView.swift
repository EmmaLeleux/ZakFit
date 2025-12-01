//
//  RegimeAlimentaireView.swift
//  ZakFit
//
//  Created by Emma on 30/11/2025.
//

import SwiftUI

struct RegimeAlimentaireView: View {
    @Binding var diets: [DietEnum]
    var body: some View {
        VStack{
            ForEach(DietEnum.allCases, id: \.self){diet in
                
                Button(action:{
                    if diets.contains(diet){
                        diets.remove(at: diets.firstIndex(of: diet)!)
                    }
                    else{
                        diets.append(diet)
                    }
                }, label: {
                    HStack{
                        if diets.contains(diet){
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.greenApp)
                                    .frame(width: 30, height: 30)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10).stroke( Color.greenApp)
                                    }
                                Image(.checkSymbol)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 18)
                            }
                        }
                        
                        else{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( Color.greenApp)
                                .frame(width: 30, height: 30)
                            
                            
                        }
                        Text(diet.rawValue)
                        Spacer()
                    }
                })
            }
        }
        .padding()
        .background(.secondaire)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
    }
}

#Preview {
    RegimeAlimentaireView(diets: .constant([]))
}
