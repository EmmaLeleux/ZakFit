//
//  UserViewModel.swift
//  ZakFit
//
//  Created by Emma on 30/11/2025.
//

import Foundation
import Observation

@Observable
class UserViewModel{
    
    var user : User
    var profilPicker: PickerEnum = .objectifs
    var sport : SportsEnum
    var timingTraining: TimingEnum
    var timingProgression: TimingEnum
    var weightObj: WeightObjectifsEnum
    var timingPoids: TimingEnum = .deuxSemaine
    var poidsObj: Double = 0
    var popUpImage: Bool = false
  
    
    init(user: User) {
        self.user = user
        self.sport = SportsEnum(rawValue: user.sportObj) ?? .equitation
        self.timingTraining = TimingEnum(rawValue: user.timingTraining) ?? .deuxSemaine
        self.timingProgression = TimingEnum(rawValue: user.timingProgression) ?? .deuxSemaine
        self.weightObj = WeightObjectifsEnum(rawValue: user.typeWeightObj) ?? .maintainWeight
        
    }
    
}
