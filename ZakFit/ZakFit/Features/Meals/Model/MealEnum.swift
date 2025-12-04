//
//  MealEnum.swift
//  ZakFit
//
//  Created by Emma on 02/12/2025.
//

import SwiftUI

enum MealEnum: String, CaseIterable{
    case breakfast = "petit-déjeuner"
    case lunch = "déjeuner"
    case dinner = "dîner"
    case snack = "collation"
    
    
    var image : ImageResource {
        switch self {
        case .breakfast:
            return .milk
        case .lunch:
            return .bento
        case .dinner:
            return .poulet
        case .snack:
            return .cookie
        }
    }
    
    var ordre: Int{
        switch self {
        case .breakfast:
            return 0
        case .lunch:
            return 1
        case .dinner:
            return 2
        case .snack:
            return 3
        }
    }
}
