//
//  OnBoardingView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct OnBoardingView: View {
    @State var onboardingVM = OnboardingViewmodel()
    @State var dietVM = DietViewModel()
    @State var weightObjVM = WeightObjectifViewModel()
    @Environment(LoginViewModel.self) var loginVM
    var body: some View {
        VStack(alignment: .leading){
            
            
            Text("Pour mieux vous connaître.")
                .font(.custom("Quicksand", size: 26))
                .bold()
            
            Text("Afin de personnaliser au mieux votre suivi, nous avons besoin de quelques informations vous concernant.")
                .padding(.bottom, 40)
            
            TabView(selection: $onboardingVM.currentPage) {
                OnboardingPage1(onBoardingVM : $onboardingVM)
                    .tag(0)
                OnboardingPage2(onBoardingVM : $onboardingVM)
                    .tag(1)
                OnboardingPage3(onBoardingVM : $onboardingVM)
                    .tag(2)
                OnboardingPage4(onBoardingVM : $onboardingVM)
                    .tag(3)
                OnboardingPage5(onBoardingVM : $onboardingVM)
                    .tag(4)
                
                
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            
            
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: geometry.size.width, height: 20)
                        .opacity(0.7)
                        .foregroundColor(.greenApp.opacity(0.4))
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(
                            width: min((CGFloat((onboardingVM.currentPage + 1)) / 5.0) * geometry.size.width,
                                       geometry.size.width),
                            height: 20
                        )
                        .foregroundColor(.greenApp)
                }
                
            }
            .padding()
            .frame(height: 30)
            
            
            
            HStack{
                Spacer()
                if onboardingVM.currentPage == 4 {
                    Button(action: {
                        
                        sendToBack()
                    }, label: {
                        Text("Terminer")
                            .padding()
                            .background(.greenApp)
                            .background(.greenApp.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                            .foregroundStyle(.backgroundApp)
                    })
                    .padding()
                }
                else {
                    Button(action: {
                        onboardingVM.currentPage += 1
                    }, label: {
                        Text("Suivant")
                            .padding()
                            .background(.greenApp)
                            .background(.greenApp.opacity(0.4))
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                            .foregroundStyle(.backgroundApp)
                    })
                    .padding()
                }
            }
            
            
        }
        .foregroundStyle(.text)
        .padding()
        
    }
    
    func sendToBack(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let birthdayString = formatter.string(from: onboardingVM.birthday)
        let aujourdhui = formatter.string(from: Date.now)
        loginVM.updateCurrentUser(with: ["genre": onboardingVM.selectedGenre?.rawValue ?? "femme", "birthday" : birthdayString, "weight" : onboardingVM.selectPoids, "height" : onboardingVM.SelectTaille, "typeWeightObj" : onboardingVM.objectifPoid.rawValue,
                                         "calByDay": onboardingVM.objCal,
                                         "objLipides" : onboardingVM.objLipides, "objGlucides" : onboardingVM.objGlucides, "objProtein" : onboardingVM.objProtein,
                                         "sportObj" : onboardingVM.sport.rawValue, "calburnobj" : onboardingVM.objCaloriesBrulees, "timingTraining" : onboardingVM.timingObjSport.rawValue, "frequenceEntrainement" : onboardingVM.frequenceEntrainement, "minProgression": onboardingVM.minProgression,   "timingProgression" : onboardingVM.timingProgression.rawValue, "trainingDuration" : onboardingVM.trainingDuration, "isOnBoardCompleted": true])
        
        for i in onboardingVM.diets{
            dietVM.createDiet(with: ["name" : i.rawValue])
        }
        
        if onboardingVM.objectifPoid != .maintainWeight{
            weightObjVM.createWeightObj(with: ["weightObjectif" : onboardingVM.nbKilo, "timing": onboardingVM.timingObjPoid.rawValue, "startDate" : aujourdhui, "finalDate" : "2026-11-30"])
        }
    }
}

#Preview {
    OnBoardingView().environment(LoginViewModel())
}
