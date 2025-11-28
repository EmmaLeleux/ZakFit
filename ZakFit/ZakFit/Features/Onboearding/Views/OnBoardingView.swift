//
//  OnBoardingView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct OnBoardingView: View {
    @State var onboardingVM = OnboardingViewmodel()
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
//                OnboardingPage5(onboardingVM: onboardingVM) {
//                    animalData.addAnimal(animal: onboardingVM.profile)
//                    showSuccessAnimation = true
//                }
//                .tag(4)
                
                
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
        .foregroundStyle(.text)
        .padding()
        
    }
}

#Preview {
    OnBoardingView()
}
