//
//  MealsView.swift
//  ZakFit
//
//  Created by Emma on 01/12/2025.
//

import SwiftUI

struct MealsView: View {
    @Environment(LoginViewModel.self) var loginVM
    @State private var date = Date()
    @State var mealVM: MealViewModel = MealViewModel()
    var body: some View {
        NavigationStack{
            ZStack {
                
                Color.backgroundApp
                    .ignoresSafeArea()
                
                if let user = loginVM.currentUser{
                    ScrollView {
                        VStack(alignment: .leading){
                            HStack{
                                Spacer()
                                
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                    .padding(14)
                                    .background(.greenApp)
                                    .clipShape(.circle)
                                    .foregroundStyle(.backgroundApp)
                                    .overlay{
                                        DatePicker(
                                            "",
                                            selection: $date,
                                            displayedComponents: [.date]
                                        )
                                        .blendMode(.destinationOver)
                                        .tint(.greenApp)
                                        
                                    }
                                
                                
                                
                            }
                            
                            
                            VStack{
                                Text(date, style: .date)
                                    .font(.custom("Quicksand", size: 24))
                                    .bold()
                                    .padding(.bottom)
                                
                                ObjNutrimentDay( user: user)
                            }
                            .padding(.bottom, 50)
                            
                            Text("Mes repas")
                                .font(.custom("Quicksand", size: 24))
                                .bold()
                                .padding(.bottom)
                            
                            
                            let today = Calendar.current.startOfDay(for: Date())
                            let comparedDay = Calendar.current.startOfDay(for: date)
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
                }
                
            }
        }
        .foregroundStyle(.text)
        .environment(mealVM)
        .task{
            
            await mealVM.ensureFourMeals(for: date)
            mealVM.fetchMeals(date: date)
            
        }
        .onChange(of: date) { newDate in
            Task {
                 await mealVM.ensureFourMeals(for: newDate)
                mealVM.fetchMeals(date: date)
                
                }
        }
        
    }
    
}

#Preview {
    MealsView().environment(LoginViewModel())
}
