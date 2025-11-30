//
//  OnboardingPage4.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import SwiftUI

struct OnboardingPage4: View {
    @Binding var onBoardingVM: OnboardingViewmodel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quel est votre objectif calorique ?")
                .font(.title2)
                .bold()
            
            ObjectifPoidsView(onBoardingVM: $onBoardingVM)
                .padding(.bottom)
            ObjectifCalView(onBoardingVM: $onBoardingVM)
            
            Spacer()
            
        }
    }
}

#Preview {
    OnboardingPage4(onBoardingVM: .constant(OnboardingViewmodel()))
}
