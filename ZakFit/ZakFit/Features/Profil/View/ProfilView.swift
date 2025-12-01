//
//  ProfilView.swift
//  ZakFit
//
//  Created by Emma on 30/11/2025.
//

import SwiftUI

struct ProfilView: View {
    @Environment(LoginViewModel.self) var loginVM
    @State var userVM : UserViewModel
    @State var WeightObj = WeightObjectifViewModel()
    @State var dietVM = DietViewModel()
    var body: some View {
        
        ZStack{
            Color.backgroundApp
                .ignoresSafeArea()
                ScrollView{
                    if let user = loginVM.currentUser{
                        
                        Button(action: {
                            userVM.popUpImage.toggle()
                        }, label:{
                            AsyncImage(url: URL(string: userVM.user.profil_picture)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .background(.greenApp.opacity(0.4))
                                    .clipShape(.circle)
                                
                            } placeholder: {
                                ProgressView()
                            }
                        })
                        
                        
                        Text("\(user.firstname) \(user.lastname)")
                            .font(.custom("Quicksand", size: 20))
                            .bold()
                            .foregroundStyle(.greenApp)
                        
                        HStack{
                            TextFieldProfilView(number: $userVM.user.age, text: "ans")
                            TextFieldDoubleView(number: $userVM.user.weight, text: "Kg")
                            TextFieldProfilView(number: $userVM.user.height, text: "cm")
                            
                            
                        }
                        .multilineTextAlignment(.center)
                        
                        
                        HStack(spacing: 0){
                            Button(action: {
                                userVM.profilPicker = .objectifs
                            }, label: {
                                if userVM.profilPicker == .objectifs{
                                    
                                    HStack{
                                        Spacer()
                                        Text("Objectifs")
                                            .font(.custom("Quicksand", size: 15))
                                            .bold()
                                            .foregroundStyle(.backgroundApp)
                                        Spacer()
                                    }
                                    .padding(10)
                                    .background(.greenApp)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                                }
                                else{
                                    HStack{
                                        Spacer()
                                        Text("Objectifs")
                                            .font(.custom("Quicksand", size: 15))
                                            .bold()
                                            .foregroundStyle(.greenApp)
                                        Spacer()
                                    }
                                    .padding(10)
                                    
                                }
                            })
                            
                            Button(action: {
                                userVM.profilPicker = .regime
                            }, label: {
                                if userVM.profilPicker == .regime{
                                    
                                    HStack{
                                        Spacer()
                                        Text("Régime alimentaire")
                                            .font(.custom("Quicksand", size: 15))
                                            .bold()
                                            .foregroundStyle(.backgroundApp)
                                        Spacer()
                                    }
                                    .padding(10)
                                    .background(.greenApp)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
                                }
                                
                                else{
                                    HStack{
                                        Spacer()
                                        Text("Régime alimentaire")
                                            .font(.custom("Quicksand", size: 15))
                                            .bold()
                                            .foregroundStyle(.greenApp)
                                        Spacer()
                                    }
                                    .padding(10)
                                    
                                }
                            })
                        }
                        .padding(.vertical, 30)
                        
                        
                        
                        if  userVM.profilPicker == .objectifs{
                            
                            let bindingKilo = Binding<Double>(
                                get: { WeightObj.weightObj? .weightObjectif ?? 0.0 },
                                set: { newValue in
                                    WeightObj.weightObj?.weightObjectif = Double(newValue)
                                }
                            )
                            
                            
                            ObjectifPoidsView(objectifPoid: $userVM.weightObj, nbKilo: $userVM.poidsObj, timingObjPoid: $userVM.timingPoids)
                                .padding(.bottom)
                            
                            ObjectifCalView(objCal: $userVM.user.calByDay, objLipides: $userVM.user.objLipides, objGlucides: $userVM.user.objGlucides, objProtein: $userVM.user.objProtein)
                                .padding(.bottom)
                            
                            ObjectifActivity(sport: $userVM.sport , objCal: $userVM.user.calburnobj, frequenceEntrainement: $userVM.user.frequenceEntrainement, trainingDuration: $userVM.user.trainingDuration, timingObjSport: $userVM.timingTraining, minProgression: $userVM.user.minProgression, timingProgression: $userVM.timingProgression)
                                .padding(.bottom)
                        }
                        
                        else{
                            RegimeAlimentaireView(diets: $dietVM.dietsFetch)
                                .foregroundStyle(.text)
                        }
                    }
                    
                    Button(action: {
                        updateUser()
                    }, label: {
                        Text("Enregistrer")
                            .padding()
                            .frame(width: 200)
                            .background(.greenApp)
                            .foregroundStyle(.backgroundApp)
                            .clipShape(Capsule())
                            .bold()
                    })
                    .padding()
                }
                .scrollIndicators(.hidden)
                
                
            .task{
                await loadData()
                
                
                
                
            }
            .padding(.horizontal)
            
            if userVM.popUpImage{
                Color.gray.opacity(0.5)
                    .ignoresSafeArea()
                
                PopUpImageView(photoProfil: $userVM.user.profil_picture, showPopUp: $userVM.popUpImage)
                    .padding()
            }
            
        }
    }
    
    func updateUser(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let aujourdhui = formatter.string(from: Date.now)
        if let objPoids = WeightObj.weightObj{
            
                WeightObj.deleteWeightObj(obj: objPoids)
            
            
        }
        if userVM.weightObj != .maintainWeight{
            WeightObj.createWeightObj(with: ["weightObjectif" : userVM.poidsObj, "timing" : userVM.timingPoids.rawValue, "startDate" : aujourdhui, "finalDate" : aujourdhui]
            )
            
        }
        
        for diet in DietEnum.allCases{
            if dietVM.dietsFetch.contains(where: { $0.rawValue == diet.rawValue}) && !dietVM.diets.contains(where: { $0.name == diet.rawValue}){
                dietVM.createDiet(with: ["name" : diet.rawValue])
            }
            else if !dietVM.dietsFetch.contains(where: { $0.rawValue == diet.rawValue}) && dietVM.diets.contains(where: { $0.name == diet.rawValue}){
                
                if let dietToDelete = dietVM.diets.filter({ $0.name == diet.rawValue}).first{
                    dietVM.deleteDiet(obj: dietToDelete)
                }
                
            }
        }
        
        
        
        loginVM.updateCurrentUser(with: ["age" : userVM.user.age, "weight" : userVM.user.weight, "height" : userVM.user.height, "profil_picture" : userVM.user.profil_picture, "lastname" : userVM.user.lastname, "firstname" : userVM.user.firstname, "typeWeightObj" : userVM.weightObj.rawValue, "sportObj" : userVM.sport.rawValue, "calburnobj" : userVM.user.calburnobj, "timingCal": userVM.user.timingCal, "timingTraining" : userVM.timingTraining.rawValue,  "trainingDuration" : userVM.user.trainingDuration, "calByDay" : userVM.user.calByDay, "objLipides" : userVM.user.objLipides, "objGlucides" : userVM.user.objGlucides, "objProtein" : userVM.user.objProtein, "minProgression" : userVM.user.minProgression, "timingProgression" : userVM.timingProgression.rawValue, "frequenceEntrainement": userVM.user.frequenceEntrainement])
    }
    
    func loadData() async{
       
        await WeightObj.fetchWeight()
        dietVM.fetchDiets()
        userVM.user = loginVM.currentUser ?? User(id: UUID(), lastname: "", firstname: "", email: "", age: 0, profil_picture: "", weight: 0.0, height: 0, notifHour: "", typeWeightObj: "", sportObj: "", calburnobj: 0, timingCal: "", startDate: "", finalDate: "", timingTraining: "", nbTraining: 0, trainingDuration: 0, calByDay: 0, genre: "", objLipides: 0, objProtein: 0, objGlucides: 0, frequenceEntrainement: 0, minProgression: 0, timingProgression: "", isOnBoardCompleted: true)
        
        
        if let objPoids = WeightObj.weightObj{
            userVM.timingPoids = TimingEnum(rawValue: objPoids.timing) ?? .deuxSemaine
            
            userVM.poidsObj = objPoids.weightObjectif
        }
    }
}

#Preview {
    ProfilView(userVM: UserViewModel(user: User(id: UUID(), lastname: "", firstname: "", email: "", age: 0, profil_picture: "", weight: 0.0, height: 0, notifHour: "", typeWeightObj: "", sportObj: "", calburnobj: 0, timingCal: "", startDate: "", finalDate: "", timingTraining: "", nbTraining: 0, trainingDuration: 0, calByDay: 0, genre: "", objLipides: 0, objProtein: 0, objGlucides: 0, frequenceEntrainement: 0, minProgression: 0, timingProgression: "", isOnBoardCompleted: true))).environment(LoginViewModel())
}
