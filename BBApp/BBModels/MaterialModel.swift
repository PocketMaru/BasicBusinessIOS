//
//  MaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/19/25.
//

import Foundation
// Material Units of Measurement
enum ProductUnitTypes {
    case gallon
    case liter
    case ounce
    case pound
    case bag
    case unit
    case piece
    case gram
}
// Model defining materials purchased for quotes, and materials on hand in inventory
struct MaterialModel {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
}

