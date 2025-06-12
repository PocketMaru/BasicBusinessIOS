//
//  MaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/19/25.
//

import Foundation
// Model defining materials purchased for quotes, and materials on hand in inventory
struct MaterialModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
}
// Extension for sample data.
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
