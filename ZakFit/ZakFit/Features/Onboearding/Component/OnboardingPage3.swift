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
        VStack(alignment: .leading) {
            Text("Quel est votre régime alimentaire ?")
                .font(.title2)
                .bold()
            
            VStack{
                ForEach(DietEnum.allCases, id: \.self){diet in
                    
                    Button(action:{
                        if onBoardingVM.diets.contains(diet){
                            onBoardingVM.diets.remove(at: onBoardingVM.diets.firstIndex(of: diet)!)
                        }
                        else{
                            onBoardingVM.diets.append(diet)
                        }
                    }, label: {
                        HStack{
                            if onBoardingVM.diets.contains(diet){
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(.greenApp)
                                        .frame(width: 30, height: 30)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 10).stroke( Color.greenApp)
                                        }
                                    Image(.checkSymbol)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 18)
                                }
                            }
                            
                            else{
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke( Color.greenApp)
                                    .frame(width: 30, height: 30)
                                
                                
                            }
                            Text(diet.rawValue)
                            Spacer()
                        }
                    })
                }
            }
            .padding()
            .background(.secondaire)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
            .padding(.vertical)
            Spacer()
        }
    }
}

#Preview {
    OnboardingPage3(onBoardingVM: .constant(OnboardingViewmodel()))
}
