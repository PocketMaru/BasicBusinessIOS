//
//  MaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/19/25.
//

import Foundation

enum MaterialUnitTypes {
    case gallon
    case liter
    case ounce
    case pound
    case bag
    case unit
    case piece
}

struct MaterialModel {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var quantityAvailable: Int
    var unitType: MaterialUnitTypes
}
