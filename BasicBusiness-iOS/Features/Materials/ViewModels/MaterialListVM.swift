import Foundation

@MainActor
@Observable
final class MaterialListVM {
    private(set) var allMaterials: [MaterialModel] = []

    init() {}

    // Adding materials to the material model
    func addMaterial(id: UUID, name: String, description: String?, unitCost: Double, unitType: ProductUnitTypes) {
        let newMaterial = MaterialModel(
            id: id,
            name: name,
            description: description,
            unitCost: unitCost,
            unitType: unitType
        )
        allMaterials.append(newMaterial)
    }

    // Removal of materials stored
    func removeMaterial(at index: Int) {
        guard index >= 0, index < allMaterials.count else { return }
        allMaterials.remove(at: index)
    }
}
