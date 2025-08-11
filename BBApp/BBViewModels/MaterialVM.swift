//
//  MaterialVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation
@Observable
final class MaterialVM {
    private(set) var materials: [MaterialModel] = []
    private(set) var quoteMaterials: [MaterialExpenseQM] = []
    
    init(materials: [MaterialModel]) {
        self.materials = materials
    }
    // Adding materials to the material model
    func addMaterial(
        id: UUID,
        name: String,
        description: String?,
        unitCost: Double,
        unitType: ProductUnitTypes
    ) {
        guard !materials.contains(where: { $0.id == id }) else { return }
        
        let newMaterial = MaterialModel(
            id: id, name: name,
            description: description,
            unitCost: unitCost,
            unitType: unitType
        )
        materials.append(newMaterial)
    }
    // Adding materials to the quote
    func addMaterialToQuote (from savedMaterial: MaterialModel, markAsExpense: Bool = false) {
        let quoteMaterial = MaterialExpenseQM(from: savedMaterial, addedAsExpense: markAsExpense)
        quoteMaterials.append(quoteMaterial)
    }
    // Adding materials from quote to material storage
    func addMaterialExpenseToStorage(_ expense: MaterialExpenseQM) {
        addMaterial(
            id: expense.id,
            name: expense.name,
            description: expense.description,
            unitCost: expense.unitCost,
            unitType: expense.unitType
        )
    }
    // Removal of materials stored
    func removeStoredMaterial(at index: Int) {
        guard index >= 0 && index < materials.count else { return }
        materials.remove(at: index)
    }
}
