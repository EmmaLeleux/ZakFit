//
//  AddActivityView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(ActivityViewModel.self) var activityVM
    @State var activite: SportsEnum? = nil
    @State var duration: Int = 0
    @State var intensity: IntensityEnum? = nil
    @State var calories: Int = 0
    @Binding var isPresented: Bool
    var caloriesRecommandees: Int{
        if let intensity = intensity, let sport = activite{
            switch intensity {
            case .low:
                return duration * sport.calByMinFaible
            case .moderate:
                return duration * sport.calByMinModere
            case .high:
                return duration * sport.calByMinIntense
            }
        }
        return 40
    }
    @FocusState var isFocused: Bool
    var body: some View {
        ZStack {
            Color.secondaire.ignoresSafeArea()
            
            VStack{
                Text("Ajouter un entraînement")
                    .font(.custom("Quicksand", size: 22))
                    .bold()
                
                VStack(alignment: .leading) {
                    ForEach(SportsEnum.allCases, id:\.self){ sport in
                        
                        Button(action: {
                            activite = sport
                        }, label: {
                            
                            HStack{
                                if activite == sport{
                                    
                                    ZStack{
                                        Circle()
                                            .foregroundStyle(.greenApp)
                                            .frame(width: 20, height: 20)
                                            .overlay{
                                                Circle().stroke( Color.greenApp)
                                            }
                                        Image(.checkSymbol)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10)
                                    }
                                }
                                
                                else{
                                    Circle()
                                        .stroke( Color.greenApp)
                                        .frame(width: 20, height: 20)
                                    
                                    
                                }
                                
                                Text(sport.rawValue)
                                    .foregroundStyle(.text)
                                
                                Spacer()
                            }
                        })
                    }
                    
                    VStack {
                        HStack{
                            Text("Intensité de la séance")
                            Spacer()
                        }
                        
                        HStack{
                            ForEach(IntensityEnum.allCases, id:\.self){ intensite in
                            
                                Button(action:{
                                    intensity = intensite
                                }, label:{
                                    Text(intensite.rawValue)
                                        .padding(8)
                                        .foregroundStyle(intensity == intensite ? .backgroundApp : .text)
                                        .background( .greenApp.opacity(intensity == intensite ? 1 : 0.4))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }).padding()
                            }
                        }
                        HStack{
                            HStack{
                                Image(.montre)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                
                                
                                TextField("min", value: $duration , format: .number)
                                    .padding(13)
                                    .frame(width: 70)
                                    .background(.greenApp)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                                    .foregroundStyle(.backgroundApp)
                                    .onSubmit {
                                        isFocused.toggle()
                                    }
                                
                                Text("min")
                            }
                            Spacer()
                            HStack{
                                Image(.flamme)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                
                                
                                TextField("Kcal", value: $calories , format: .number)
                                    .padding(13)
                                    .frame(width: 70)
                                    .background(.greenApp)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                                    .foregroundStyle(.backgroundApp)
                                    .onSubmit {
                                        isFocused.toggle()
                                    }
                                
                                Text("Kcal")
                            }
                        }
                        
                        if intensity != nil && duration != 0 && activite != nil{
                            Text("D'après nos calculs, vous devriez avoir consommé environ \(caloriesRecommandees) Kcal sur cette séance.")
                                .padding(.vertical, 7)
                            
                            Button(action: {
                                calories = caloriesRecommandees
                            }, label: {
                                Text("Choisir cette valeur")
                                    
                                    .frame(width: 200)
                                    
                                    .foregroundStyle(.greenApp)
                                    
                                    .bold()
                            })
                            
                            
                        }
                            
                        Button(action: {
                            Task{
                                if duration != 0 && activite != nil{
                                    
                                    await activityVM.createActivity(with: CreateActivity(sport: activite?.rawValue ?? "", date: Date().toString(), cal: calories, duration: duration))
                                    
                                    isPresented.toggle()
                                }
                                
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
                        .padding(.top, 60)
                        
                    }.padding(.top, 50)
                }
            }.padding()
        }
        .foregroundStyle(.text)
    }
}

#Preview {
    AddActivityView(isPresented: .constant(true)).environment(ActivityViewModel())
}
