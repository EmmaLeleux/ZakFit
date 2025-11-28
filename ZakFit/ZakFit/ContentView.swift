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
                    //ajouter condition
                    
                    OnBoardingView()
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
