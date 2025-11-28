//
//  GenreEnum.swift
//  ZakFit
//
//  Created by Emma on 28/11/2025.
//

import SwiftUI
enum GenreEnum: String, CaseIterable {
    case homme
    case femme
    case autre
    
    var image : ImageResource {
        switch self {
        case .homme:
            return .logoHomme
        case .femme:
            return .logoFemme
        case .autre:
            return .logoAutre
        }
    }
}
