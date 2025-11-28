//
//  InscriptionView.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import SwiftUI

struct InscriptionView: View {
    @State var connexionVM: ConnexionViewModel = ConnexionViewModel()
    @Binding var isConnexion: Bool
    @Environment(LoginViewModel.self) var loginVM
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
                Text("Inscription")
                    .font(.custom("Quicksand", size: 32))
                    .bold()
                    
                Spacer()
                
                VStack(spacing: 40){
                    TextFieldComponentView(placeholder: "Nom", text: $connexionVM.lastname)
                    
                    TextFieldComponentView(placeholder: "Prénom", text: $connexionVM.firstname)
                    
                    TextFieldComponentView(placeholder: "Email", text: $connexionVM.email)
                    
                    
                    TextFieldComponentView(placeholder: "Mot de passe", text: $connexionVM.mdp, secured: true)
                    
                    TextFieldComponentView(placeholder: "Confirmer mot de passe", text: $connexionVM.mdpconfirm, secured: true)
                    
                    
                    
                    
                }
                .padding()
                .foregroundStyle(.text)
                
                Spacer()
                if let error = loginVM.errorMessage {
                    Text(error).foregroundColor(.red)
                }
                Button(action:{
                    Task{
                        try await loginVM.createUser(lastname: connexionVM.lastname, firstname: connexionVM.firstname, email: connexionVM.email, password: connexionVM.mdp)
                    }
                }, label: {
                    Text("S'inscrire")
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
                    Text("Déjà un compte ?")
                        .foregroundStyle(.text)
                    
                    
                    Button(action:{
                        isConnexion = true
                    }, label: {
                        Text("Se connecter")
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
    InscriptionView(isConnexion: .constant(false)).environment(LoginViewModel())
}
