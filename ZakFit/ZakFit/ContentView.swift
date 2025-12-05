//
//  ContentView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct ContentView: View {
    @State var loginVM = LoginViewModel()
    
    var body: some View {
        ZStack{
            Color.backgroundApp
                .ignoresSafeArea()
            
            
                VStack{
                    
                    if loginVM.isAuthenticated{
                        NavigationStack {
                            if let user = loginVM.currentUser{
                                if user.isOnBoardCompleted{
                                    
                                    TabView{
                                        
                                        
                                        DashboardView()
                                            .tabItem {
                                                Image("IconDashboard")
                                                
                                                Text("Dashboard")
                                            }
                                        
                                        
                                        RapportView()
                                            .tabItem {
                                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                                
                                                Text("Rapports")
                                            }
                                        
                                        
                                        ActivityView()
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
                    }
                    else{
                        authentificationView()
                    }
                }
            
        }
        .environment(loginVM)
      
    }
}

#Preview {
    ContentView()
}
