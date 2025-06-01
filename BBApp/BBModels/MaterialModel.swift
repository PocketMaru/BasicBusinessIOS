//
//  MaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/19/25.
//

import Foundation
// Model defining materials purchased for quotes, and materials on hand in inventory
struct MaterialModel {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
}

