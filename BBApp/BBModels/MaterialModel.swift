//
//  MaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/19/25.
//

import Foundation
/// Struct `MaterialModel` defines reusable materials that can be referenced when building quotes.
/// This is **not** an inventory tracker — instead, it stores commonly used materials and pricing
/// to make quoting faster and more consistent.
/// Each time a material is added to a quote, a new expense entry is created — quantities are not deducted or tracked.
/// Enumeration `ProductUnitTypes`defining the units of measurement of materials within the app
/// Enumeration `UnitCategory` defining the type of measurement of the material (e.g., Volume, Quantity)
/// Extension to `MaterialModel` provides sample data for preview/testing
struct MaterialModel: Identifiable {
    
    /// Unique identifier for materials
    var id: UUID = UUID()
    
    /// Material name
    var name: String
    
    /// Optional description of material
    var description: String?
    
    /// Cost per unit of material
    var unitCost: Double
    
    /// Material unit type ( e.g., Gallon, Liter, Ounce, Pound)
    var unitType: ProductUnitTypes
    
}

enum ProductUnitTypes: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
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
    
    var category: UnitCategory {
        switch self {
        case .gram, .ounce, .pound:
            return .weight
        case .liter, .gallon:
            return .volume
        case .bag, .unit, .piece:
            return .quantity
        }
    }
}

enum UnitCategory {
    case volume
    case weight
    case quantity
}

/// Extension of `MaterialModel` for samples
extension MaterialModel {
    static let sample = MaterialModel(
        id: UUID(),
        name: "2x15",
        description: "High quality pressure treated lumber",
        unitCost: 100.00,
        unitType: .piece
    )
    
    static let sampleList: [MaterialModel] = [
        .sample,
        MaterialModel(id: UUID(), name: "2X4", unitCost: 8.99, unitType: .unit),
        MaterialModel(id: UUID(), name: "2X2", unitCost: 12.99, unitType: .unit),
        MaterialModel(id: UUID(), name: "2X10", unitCost: 16.99, unitType: .unit)
    ]
}
