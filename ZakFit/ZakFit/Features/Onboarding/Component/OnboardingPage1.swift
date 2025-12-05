//
//  OnboardingPage1.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import SwiftUI

struct OnboardingPage1: View {
    @Binding var onBoardingVM: OnboardingViewmodel
    var body: some View {
        ZStack {
            Color.backgroundApp.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Quel est votre genre ?")
                    .font(.title2)
                    .bold()
                
                ForEach(GenreEnum.allCases, id:\.self){ genre in
                    Button(action: {
                        onBoardingVM.selectedGenre = genre
                    }, label: {
                        if onBoardingVM.selectedGenre == genre {
                            HStack{
                                Image(genre.image)
                                Text(genre.rawValue)
                                    .font(.system(size: 18))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding()
                            .frame(width: 150)
                            .background(.greenApp.opacity(0.4))
                            
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        }
                        else{
                            HStack{
                                Image(genre.image)
                                Text(genre.rawValue)
                                    .font(.system(size: 18))
                            }.padding()
                            
                        }
                        
                    })
                    
                }
                
                
                Text("Quelle est votre date de naissance ?")
                    .font(.title2)
                    .bold()
                    .padding(.vertical)
                
                HStack{
                    Text(onBoardingVM.birthday, style: .date)
                    
                        .overlay{
                            DatePicker( selection: $onBoardingVM.birthday, in: ...Date(), displayedComponents: .date){
                                Text("Selectionnez une date :")
                                    .foregroundStyle(.white)
                            }
                            .opacity(0.1)
                            .tint(.greenApp)
                        }
                    
                    
                }
                .padding()
                .background(.greenApp.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                
                Spacer()
                
            }
        }
    }
}

#Preview {
    OnboardingPage1( onBoardingVM: .constant(OnboardingViewmodel()))
}
