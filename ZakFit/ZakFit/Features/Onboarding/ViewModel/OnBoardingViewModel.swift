//
//  OnBoardingViewModel.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import Foundation

@Observable
class OnboardingViewmodel {
    var currentPage = 0
    var selectedGenre: GenreEnum? = nil
    var birthday: Date = Date.now
    var selectPoids: Int = 60
    var SelectTaille: Int = 170
    var diets: [DietEnum] = []
    var objectifPoid: WeightObjectifsEnum = .maintainWeight
    var nbKilo: Double = 0.5
    var timingObjPoid : TimingEnum = .uneSemaine
    var objCal: Int = 1500
    var objLipides: Int = 70
    var objGlucides: Int = 100
    var objProtein: Int = 140
    var sport: SportsEnum = .yoga
    var objCaloriesBrulees = 1500
    var timingObjSport: TimingEnum = .uneSemaine
    var frequenceEntrainement = 3
    var minProgression = 0
    var timingProgression: TimingEnum = .uneSemaine
    var trainingDuration: Int = 30
    
    
    func nextPage(){
        currentPage += 1
    }
    
    func previousPage(){
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    
}
