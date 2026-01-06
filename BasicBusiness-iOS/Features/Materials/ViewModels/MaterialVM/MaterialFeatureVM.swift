import Foundation

final class MaterialFeatureVM {
    var allMaterials: [MaterialModel] = []
    private let saveMaterial = SaveMaterial()
    
    init () {
        do {
            allMaterials = try saveMaterial.load()
        } catch {
            allMaterials = []
        }
    }
    
    func addMaterial(from draft: MaterialModel) throws {
        let newMaterials = try saveMaterial.create(
            draft: draft,
            currentList: allMaterials
        )
        allMaterials = newMaterials
    }
    
    func updateMaterials(from draft: MaterialModel) throws {
        guard let _ = allMaterials.firstIndex(where: { $0.id == draft.id }) else {
            throw SaveError.writeFailed(reason: "Material not found")
        }
        let updated = try saveMaterial.update(
            material: draft,
            currentList: allMaterials
        )
        allMaterials = updated
    }
    
    func deleteMaterial(at index: Int) throws {
        guard allMaterials.indices.contains(index) else {
            throw SaveError.writeFailed(reason: "Invalid index \(index)")
        }
        let materialToRemove = allMaterials[index]
        allMaterials = try saveMaterial.delete(
            material: materialToRemove,
            currentList: allMaterials
        )
    }
    
    func materialSearchByID(with materialID: UUID) -> MaterialModel? {
        allMaterials.first(where: { $0.id == materialID })
    }
}
