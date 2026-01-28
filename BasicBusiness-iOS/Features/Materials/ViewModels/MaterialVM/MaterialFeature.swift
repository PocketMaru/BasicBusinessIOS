import Foundation
import Observation

@MainActor
@Observable
final class MaterialFeature {
    var allMaterials: [MaterialModel] = []
    private let saveMaterial = ModelStorageUseCase<MaterialModel>(filename: "materials.json")
    
    #warning("Create a load function that runs off the main thread")
    #warning("Run this function in the AppFeature on init of the app feature in a function that calls all feature load functions")
    #warning("Call this function in main tab view on load of the view")
    init () {
        do {
            allMaterials = try saveMaterial.load()
        } catch {
            allMaterials = []
        }
    }
    
    func addMaterial(from draft: MaterialModel) throws {
        let newMaterials = try saveMaterial.create(
            newModel: draft,
            currentList: allMaterials
        )
        allMaterials = newMaterials
    }
    
    func updateMaterials(from draft: MaterialModel) throws {
        let updated = try saveMaterial.update(
            updated: draft,
            currentList: allMaterials
        )
        allMaterials = updated
    }
    
    func deleteMaterial(at index: Int) throws {
        let materialToRemove = allMaterials[index]
        allMaterials = try saveMaterial.delete(
            model: materialToRemove,
            currentList: allMaterials
        )
    }
    
    func materialSearchByID(with materialID: UUID) -> MaterialModel? {
        allMaterials.first(where: { $0.id == materialID })
    }
}
