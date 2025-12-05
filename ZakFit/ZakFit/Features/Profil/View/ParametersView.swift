//
//  ParametersView.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import SwiftUI

struct ParametersView: View {
    @Environment(LoginViewModel.self) var loginVM
    @State var parameterVM = ParametersViewModel()
    var body: some View {
        
        ZStack{
            
            Color.backgroundApp.ignoresSafeArea()
            
            if let user = loginVM.currentUser{
                VStack(alignment: .leading){
                    HStack{
                        TextFieldComponentView(placeholder: user.lastname, text: $parameterVM.name)
                        
                        TextFieldComponentView(placeholder: user.firstname, text: $parameterVM.prenom)
                    }
                    
                    TextFieldComponentView(placeholder: user.email, text: $parameterVM.email)
                        .padding(.bottom, 50)
                    
                    Text("modifier son mot de passe")
                        .font(.title3)
                    
                    TextFieldComponentView(placeholder: "mot de passe actuel", text: $parameterVM.password, secured: true)
                    TextFieldComponentView(placeholder: "nouveau mot de passe", text: $parameterVM.newPassword, secured: true)
                    TextFieldComponentView(placeholder: "confirmer nouveau mot de passe", text: $parameterVM.confirmPassword, secured: true)
                    
                    VStack{
                        
                        if let error = loginVM.errorMessage {
                            
                            if error == "Tes informations ont bien été modifiées"{
                                Text(error).foregroundColor(.greenApp)
                            }
                            else{
                                Text(error).foregroundColor(.red)
                            }
                            
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                sendToUpdate()
                            }, label: {
                                Text("Enregistrer")
                                    .padding()
                                    .frame(width: 200)
                                    .background(.greenApp)
                                    .foregroundStyle(.backgroundApp)
                                    .clipShape(Capsule())
                                    .bold()
                            })
                            
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                loginVM.logout()
                                
                                print(loginVM.isAuthenticated)
                            }, label: {
                                Text("Se déconnecter")
                                    .padding()
                                    .frame(width: 200)
                                    .background(.text)
                                    .foregroundStyle(.backgroundApp)
                                    .clipShape(Capsule())
                                    .bold()
                            })
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 25)
                }
                .padding(.horizontal)
                .foregroundStyle(.text)
                
                
            }
            
        }
        
    }
    
    func sendToUpdate(){
        var newInfo = UserInfo()
        
        if parameterVM.newPassword != ""{
            newInfo.newMdp = parameterVM.newPassword
        }
        if parameterVM.email != ""{
            newInfo.email = parameterVM.email
        }
        if parameterVM.name != ""{
            newInfo.lastname = parameterVM.name
        }
        if parameterVM.prenom != ""{
            newInfo.firtsname = parameterVM.prenom
        }
        if parameterVM.password != ""{
            newInfo.mdpActuel = parameterVM.password
        }
        loginVM.updateInfoCurrentUser(with: newInfo, confirmMDP: parameterVM.confirmPassword)
    }
}

#Preview {
    ParametersView().environment(LoginViewModel())
}
