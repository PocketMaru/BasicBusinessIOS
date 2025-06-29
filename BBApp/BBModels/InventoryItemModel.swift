//
//  InventoryManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/25/25.
//

import Foundation

// Units of Measurement

struct InventoryItemModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var cost: Double
    var productQuantityType: ProductUnitTypes
    var productQuantity: Double
    var description: String?
}

enum ProductUnitTypes {
    case gram, ounce, pound, liter, gallon, bag, unit, piece
    
    var displayName: String {
        switch self {
        case .gram: return "grams"
        case .ounce: return "ounces"
        case .pound: return "pounds"
        case .liter: return "liters"
        case .gallon: return "gallons"
        case .bag: return "bags"
        case .unit: return "units"
        case .piece: return "pieces"
        }
    }
}

enum UnitCategory {
    case volume
    case weight
    case quantity
}

