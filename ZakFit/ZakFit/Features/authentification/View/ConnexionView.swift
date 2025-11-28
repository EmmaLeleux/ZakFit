//
//  ConnexionView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct ConnexionView: View {
    @State var connexionVM: ConnexionViewModel = ConnexionViewModel()
    @Environment(LoginViewModel.self) var loginVM
    @Binding var isConnexion: Bool
    var body: some View {
        ZStack{
            
            Color.clear
                    .background(
                        Rectangle()
                            .fill(.greenApp)
                            .frame(width: 850, height: 545)
                            .rotationEffect(.degrees(-55))
                            .offset(x: -190, y: -200)
                    )
            
            VStack{
                Text("Connexion")
                    .font(.custom("Quicksand", size: 32))
                    .bold()
                    
                Spacer()
                
                VStack(spacing: 40){
                    
                    if let error = loginVM.errorMessage {
                        Text(error).foregroundColor(.red)
                    }
                    TextFieldComponentView(placeholder: "Email", text: $connexionVM.email)
                    
                    
                    TextFieldComponentView(placeholder: "Mot de passe", text: $connexionVM.mdp, secured: true)
                    
                    
                    
                    
                }
                .padding()
                .foregroundStyle(.text)
                
                
                Spacer()
                Button(action:{
                    loginVM.login(email: connexionVM.email, password: connexionVM.mdp)
                }, label: {
                    Text("Se connecter")
                        .padding()
                        .frame(width: 300)
                        .background(.greenApp)
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        .shadow(color: Color.shadow.opacity(0.25), radius: 5.2, x: 1, y: 1)
                        .foregroundStyle(.backgroundApp)
                        .font(.custom("Quicksand", size: 22))
                        .bold()
                })
                .padding()
                
                
                HStack{
                    Text("Pas encore de compte ?")
                        .foregroundStyle(.text)
                    
                    
                    Button(action:{
                        isConnexion = false
                    }, label: {
                        Text("Créer un compte")
                            .foregroundStyle(.greenApp)
                    })
                }
                
            }
            .foregroundStyle(.backgroundApp)
            .padding()
        }
        
    }
}

#Preview {
    ConnexionView(isConnexion: .constant(true)).environment(LoginViewModel())
}
