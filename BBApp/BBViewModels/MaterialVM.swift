//
//  MaterialVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation

final class MaterialVM {
    private(set) var materials: [MaterialModel] = []
    private(set) var quoteMaterials: [MaterialExpenseQM] = []
    
    init(materials: [MaterialModel]) {
        self.materials = materials
    }
    
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
    
    func addMaterialToQuote (from savedMaterial: MaterialModel, markAsExpense: Bool = false) {
        let quoteMaterial = MaterialExpenseQM(from: savedMaterial, addedAsExpense: markAsExpense)
        quoteMaterials.append(quoteMaterial)
    }
    
    func saveToCatalog(from expense: MaterialExpenseQM) {
        addMaterial(
            id: expense.id,
            name: expense.name,
            description: expense.description,
            unitCost: expense.unitCost,
            unitType: expense.unitType
        )
    }
    
    func removeMaterial(at index: Int) {
        guard index >= 0 && index < materials.count else { return }
        materials.remove(at: index)
    }
}
