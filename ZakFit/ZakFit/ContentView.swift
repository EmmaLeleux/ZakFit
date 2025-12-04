//
//  ContentView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State var loginVM = LoginViewModel()
    //@State var mealVM: MealViewModel = MealViewModel()
    var body: some View {
        ZStack{
            Color.backgroundApp
                .ignoresSafeArea()
            
            VStack{
                
                if loginVM.isAuthenticated{
                    
                    if let user = loginVM.currentUser{
                        if user.isOnBoardCompleted{
                            
                            TabView{
                                
                                
                                ProfilView(userVM: UserViewModel(user: user))
                                    .tabItem {
                                        Image("IconDashboard")
                                            
                                        Text("Dashboard")
                                    }
                                
                                
                                ProfilView(userVM: UserViewModel(user: user))
                                    .tabItem {
                                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                            
                                        Text("Rapports")
                                    }
                                
                                
                                ProfilView(userVM: UserViewModel(user: user))
                                    .tabItem {
                                        Image(systemName: "figure.stairs")
                                        
                                        Text("Activités")
                                    }
                                
                                
                                
                                MealsView()
                                    .tabItem {
                                        Image(systemName: "fork.knife")

                                        Text("Repas")
                                    }
                            }
                            .tint(.greenApp)
                            .foregroundStyle(.greenApp)
                            
                            
                        }
                        else{
                            OnBoardingView()
                        }
                    }
                    
                    
                    
                }
                else{
                    authentificationView()
                }
            }
        }
        .environment(loginVM)
        //.environment(mealVM)
    }
}

#Preview {
    ContentView()
}
