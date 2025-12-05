//
//  OnboardingPage3.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import SwiftUI

struct OnboardingPage3: View {
    @Binding var onBoardingVM: OnboardingViewmodel
    var body: some View {
        ZStack {
            Color.backgroundApp.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Quel est votre régime alimentaire ?")
                    .font(.title2)
                    .bold()
                
                RegimeAlimentaireView(diets: $onBoardingVM.diets)
                    .padding(.vertical)
                Spacer()
            }
        }
    }
}

#Preview {
    OnboardingPage3(onBoardingVM: .constant(OnboardingViewmodel()))
}
