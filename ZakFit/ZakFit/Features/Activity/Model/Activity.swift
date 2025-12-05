//
//  Activity.swift
//  ZakFit
//
//  Created by Emma on 04/12/2025.
//

import Foundation

struct Activity: Codable {
    var id: UUID
    var sport: String
    var date: String
    var cal: Int
    var duration: Int
    
    
    func getEnumType() -> SportsEnum{
        return SportsEnum(rawValue: sport) ?? .equitation
    }
}
