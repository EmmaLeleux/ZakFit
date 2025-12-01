//
//  OnboardingPage5.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//

import SwiftUI

struct OnboardingPage5: View {
    @Binding var onBoardingVM: OnboardingViewmodel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quel est votre objectif d'activité physique ?")
                .font(.title2)
                .bold()
            
            ScrollView{
                ObjectifActivity(sport: $onBoardingVM.sport, objCal: $onBoardingVM.objCaloriesBrulees, frequenceEntrainement: $onBoardingVM.frequenceEntrainement, trainingDuration: $onBoardingVM.trainingDuration, timingObjSport: $onBoardingVM.timingObjSport, minProgression: $onBoardingVM.minProgression, timingProgression: $onBoardingVM.timingProgression)
            }
            Spacer()
            
        }
    }
}

#Preview {
    OnboardingPage5(onBoardingVM: .constant(OnboardingViewmodel()))
}
