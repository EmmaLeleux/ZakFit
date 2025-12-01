//
//  User.swift
//  ZakFit
//
//  Created by Emma on 27/11/2025.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var lastname: String
    var firstname: String
    var email: String
    var age: Int
    var profil_picture: String
    var weight: Double
    var height: Int
    var notifHour: String
    var typeWeightObj: String
    var sportObj: String
    var calburnobj: Int
    var timingCal: String
    var startDate: String
    var finalDate: String
    var timingTraining: String
    var nbTraining: Int
    var trainingDuration: Int
    var calByDay: Int
    var genre: String
    var objLipides: Int
    var objProtein: Int
    var objGlucides: Int
    var frequenceEntrainement: Int
    var minProgression: Int
    var timingProgression: String
    var isOnBoardCompleted: Bool
    
}
