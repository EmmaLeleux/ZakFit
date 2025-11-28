//
//  OnBoardingViewModel.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import Foundation

@Observable
class OnboardingViewmodel {
//   var profile = User()
    var currentPage = 0
    var selectedGenre: GenreEnum? = nil
    var birthday: Date = Date.now
    var selectPoids: Int = 60
    var SelectTaille: Int = 170
    var diets: [DietEnum] = []
    

//    var isPage1Valid: Bool {
//        !profile.name.isEmpty && !profile.species.isEmpty && !profile.breed.isEmpty
//    }
//    
//    var isPage2Valid: Bool {
//        !profile.sexe.isEmpty && profile.weight > 0
//    }
//    
//    var isPage5Valid: Bool {
//        if profile.isFollowingTreatment {
//            return !profile.currentTreatment.isEmpty
//        }
//        return true
//    }
    
    func nextPage(){
        currentPage += 1
    }
    
    func previousPage(){
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    
}
