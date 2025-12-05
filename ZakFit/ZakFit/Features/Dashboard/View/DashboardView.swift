//
//  DashboardView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct DashboardView: View {
    @Environment(LoginViewModel.self) var loginVM
    @State var mealVM = MealViewModel()
    var body: some View {
        ZStack{
            Color.backgroundApp.ignoresSafeArea()
            
             if let user = loginVM.currentUser{
                 VStack {
                     HStack{
                         Spacer()
                         NavigationLink(destination: {
                             ProfilView(userVM: UserViewModel(user: user))
                         }, label: {
                             AsyncImage(url: URL(string: user.profil_picture)) { image in
                                 image
                                     .resizable()
                                     .scaledToFill()
                                     .frame(width: 50, height: 50)
                                     .background(.greenApp.opacity(0.4))
                                     .clipShape(.circle)
                                 
                             } placeholder: {
                                 ProgressView()
                             }
                         })
                     }
                     Spacer()
                 }.padding(.horizontal)
            }
            VStack(spacing: 30){
                
                if let user = loginVM.currentUser{
                
                    Text("Aujourd'hui")
                        .font(.custom("Quicksand", size: 32))
                        .bold()
                    
                    
                        NavigationLink(destination: {
                            MealsView()
                        }, label: {
                            ObjNutrimentDay( user: user)
                        })
                        
                        HStack{
                            NavigationLink(destination: {
                                MealsView()
                            }, label: {
                                RepartitionMacronutrimentWidget()
                            })
                            
                            Spacer()
                            RepartitionActivity()
                        }
                        
                        
                    }
                    
                }
                .padding(.horizontal)
                .foregroundStyle(.text)
                .environment(mealVM)
                .task{
                    
                    await mealVM.ensureFourMeals(for: Date())
                    mealVM.fetchMeals(date: Date())
                    
                
            }
        }
    }
}

#Preview {
    DashboardView().environment(LoginViewModel())
}
