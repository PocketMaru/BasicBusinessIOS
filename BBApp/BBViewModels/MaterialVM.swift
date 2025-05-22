//
//  MaterialVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation

final class MaterialVM {
    var materials: [MaterialModel] = []
    
    init(materials: [MaterialModel]) {
        self.materials = materials
    }
    
    func addMaterial(id: UUID, name: String, description: String?, unitCost: Double, quantityAvailable: Int, unitType: MaterialUnitTypes ) {
        let newMaterial = MaterialModel(id: id, name: name, description: description, unitCost: unitCost, quantityAvailable: quantityAvailable, unitType: unitType)
        materials.append(newMaterial)
    }
    
    func removeMaterial(at index: Int) {
        guard index >= 0 && index < materials.count else { return }
        materials.remove(at: index)
    }
    // Modifying the MaterialModels data to reflect what was used
    func subtractMaterials(from material: inout MaterialModel, by expense: MaterialExpenseQM) {
        material.quantityAvailable = max(0, material.quantityAvailable - expense.quantityUsed)
        
    }
}
