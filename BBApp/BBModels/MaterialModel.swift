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
/// Extension to `MaterialModel` provides sample data for preview/testing
struct MaterialModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
}

extension MaterialModel {
    static let sample = MaterialModel(
        id: UUID(),
        name: "Wood",
        description: "High quality pressure treated lumber",
        unitCost: 100.00,
        unitType: .piece
    )
    
    static let sampleList: [MaterialModel] = [
        .sample,
        MaterialModel(id: UUID(), name: "2X4s", unitCost: 8.99, unitType: .unit),
        MaterialModel(id: UUID(), name: "2X2s", unitCost: 12.99, unitType: .unit),
        MaterialModel(id: UUID(), name: "2X10s", unitCost: 16.99, unitType: .unit)
    ]
}
