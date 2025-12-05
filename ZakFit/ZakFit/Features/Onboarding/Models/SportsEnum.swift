//
//  SportsEnum.swift
//  ZakFit
//
//  Created by Emma on 29/11/2025.
//
import SwiftUI

enum SportsEnum: String, CaseIterable {
    case yoga
    case equitation = "équitation"
    case musculation
    case natation
    case pilate
    case stretching
    
    var image : ImageResource {
        switch self {
        case .yoga:
            return .yoga
        case .equitation:
            return .equitation
        case .musculation:
            return .musculation
        case .natation:
            return .natation
        case .pilate:
            return .pilate
        case .stretching:
            return .stretching
        }
    }

    var calByMinFaible: Int {
        switch self {
        case .yoga:
            return 3
        case .equitation:
            return 4
        case .musculation:
            return 5
        case .natation:
            return 6
        case .pilate:
            return 4
        case .stretching:
            return 2
        }
    }
    
    var calByMinModere: Int {
        switch self {
        case .yoga:
            return 4
        case .equitation:
            return 6
        case .musculation:
            return 8
        case .natation:
            return 10
        case .pilate:
            return 6
        case .stretching:
            return 3
        }
    }
    
    var calByMinIntense: Int {
        switch self {
        case .yoga:
            return 6
        case .equitation:
            return 8
        case .musculation:
            return 10
        case .natation:
            return 14
        case .pilate:
            return 8
        case .stretching:
            return 5
        }
    }
    
    var couleur: Color {
        switch self {
        case .yoga:
            return .yoga
        case .equitation:
            return .equitation
        case .musculation:
            return .musculation
        case .natation:
            return .natation
        case .pilate:
            return .pilate
        case .stretching:
            return .stretching
        }
    }
}
