//
//  OnboardingPage2.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import SwiftUI

struct OnboardingPage2: View {
    @Binding var onBoardingVM: OnboardingViewmodel
    var body: some View {
        
        ZStack {
            Color.backgroundApp.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Quel est votre poids ?")
                    .font(.title2)
                    .bold()
                
                ZStack{
                    Text("Kg")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.greenApp)
                        .offset(x:38)
                    Picker("poids", selection: $onBoardingVM.selectPoids){
                        
                        
                        ForEach(0...200, id: \.self){ int in
                            
                            Text(int.description).tag(int)
                                .foregroundStyle(.text)
                                .bold()
                            
                            
                        }
                    }
                    .pickerStyle(.wheel)
                    .tint(.greenApp)
                    .foregroundStyle(.greenApp)
                    
                }
                
                Text("Quel est votre taille ?")
                    .font(.title2)
                    .bold()
                
                ZStack{
                    Text("cm")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.greenApp)
                        .offset(x:40)
                    Picker("poids", selection: $onBoardingVM.SelectTaille){
                        
                        
                        ForEach(30...300, id: \.self){ int in
                            
                            Text(int.description).tag(int)
                                .foregroundStyle(.text)
                                .bold()
                            
                            
                        }
                    }
                    .pickerStyle(.wheel)
                    .tint(.greenApp)
                    .foregroundStyle(.greenApp)
                    
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingPage2(onBoardingVM: .constant(OnboardingViewmodel()))
}
