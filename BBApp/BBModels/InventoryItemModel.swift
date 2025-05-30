//
//  InventoryManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/25/25.
//

import Foundation

struct InventoryItemModel {
    var id: UUID = UUID()
    var name: String
    var cost: Double
    var productQuantityType: ProductUnitTypes
    var productQuantity: Double
    var description: String?
}
