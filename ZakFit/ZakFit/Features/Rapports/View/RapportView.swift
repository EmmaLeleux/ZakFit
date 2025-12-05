//
//  RapportView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct RapportView: View {
    @State private var month = Date()
    @State var mealVM = MealViewModel()
    @State var activityVM = ActivityViewModel()
    @State var picker = 0
    
    var body: some View {
        ZStack {
            Color.backgroundApp
                .ignoresSafeArea()
            
            ScrollView{
                VStack{
                    CalendarMonth(month: $month)
                      
                    
                    HStack(spacing: 0){
                        Button(action: {
                            picker = 0
                        }, label: {
                            if picker == 0{
                                
                                HStack{
                                    Spacer()
                                    Text("Repas")
                                        .font(.custom("Quicksand", size: 15))
                                        .bold()
                                        .foregroundStyle(.backgroundApp)
                                    Spacer()
                                }
                                .padding(10)
                                .background(.greenApp)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                            }
                            else{
                                HStack{
                                    Spacer()
                                    Text("Repas")
                                        .font(.custom("Quicksand", size: 15))
                                        .bold()
                                        .foregroundStyle(.greenApp)
                                    Spacer()
                                }
                                .padding(10)
                                
                            }
                        })
                        
                        Button(action: {
                            picker = 1
                        }, label: {
                            if picker == 1{
                                
                                HStack{
                                    Spacer()
                                    Text("Activités")
                                        .font(.custom("Quicksand", size: 15))
                                        .bold()
                                        .foregroundStyle(.backgroundApp)
                                    Spacer()
                                }
                                .padding(10)
                                .background(.greenApp)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                            }
                            
                            else{
                                HStack{
                                    Spacer()
                                    Text("Activités")
                                        .font(.custom("Quicksand", size: 15))
                                        .bold()
                                        .foregroundStyle(.greenApp)
                                    Spacer()
                                }
                                .padding(10)
                                
                            }
                        })
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal)
                    
                    if picker == 0{
                        let today = Calendar.current.startOfDay(for: Date())
                        let comparedDay = Calendar.current.startOfDay(for: month)
                        
                        VStack{
                        if today < comparedDay {
                            Text("Même toi tu ne sais pas encore ce que tu va manger ce jour là, reviens plus tard !")
                        }
                        else{
                            
                            
                            ForEach($mealVM.meals){ $meal in
                                
                                OneMealView( meal: $meal)
                                
                            }
                        }
                    }
                        .padding(.horizontal)
                    }
                    
                    else{
                        if activityVM.activitys.isEmpty{
                            Text("Tu n'as rien fait ce jour là, les jours de repos c'est important aussi !")
                        }
                        else{
                            ForEach(activityVM.activitys, id: \.id){activity in
                                
                                OneActivityView(activity: activity)
                                
                            }
                        }
                    }
                }
            }
        }
        .foregroundStyle(.text)
        .environment(mealVM)
        .task{
            
            await mealVM.ensureFourMeals(for: month)
            mealVM.fetchMeals(date: month)
            activityVM.fetchActivitys(date: month)
            
        }
        .onChange(of: month) { newDate in
            Task {
              
                 await mealVM.ensureFourMeals(for: newDate)
                mealVM.fetchMeals(date: newDate)
                activityVM.fetchActivitys(date: newDate)
                }
        }
    }
}

#Preview {
    RapportView()
}
