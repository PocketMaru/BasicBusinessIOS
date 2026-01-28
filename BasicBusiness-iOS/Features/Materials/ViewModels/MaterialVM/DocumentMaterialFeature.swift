import Foundation

import Foundation

@MainActor
@Observable
final class DocumentMaterialFeature {
    var allDocumentMaterials: [DocumentMaterialModel] = []
    private let saveDocumentMaterial = ModelStorageUseCase<DocumentMaterialModel>(filename: "documentMaterialModels.json")
    
    init () {
        do {
            allDocumentMaterials = try saveDocumentMaterial.load()
        } catch {
            allDocumentMaterials = []
        }
    }
    
    func validateMaterialExists(
        _ material: DocumentMaterialModel,
        availableMaterials: [MaterialModel],
        message: String
    ) throws {
        guard availableMaterials.contains(where: { $0.id == material.materialID }) else {
            throw DocumentMaterialError.writeFailed(reason: message)
        }
    }
    
    func addDocumentMaterial(
        _ material: DocumentMaterialModel,
        availableMaterials: [MaterialModel]
    ) throws {
        try validateMaterialExists(
            material,
            availableMaterials: availableMaterials,
            message: "Material does not exist"
        )
        let newDocMaterial = try saveDocumentMaterial.create(newModel: material, currentList: allDocumentMaterials)
        allDocumentMaterials = newDocMaterial
    }
    
    func updateDocumentMaterials(
        _ material: DocumentMaterialModel,
        availableMaterials: [MaterialModel]
    ) throws {
        try validateMaterialExists(
            material,
            availableMaterials: availableMaterials,
            message: "Material no longer available"
        )
        let updated = try saveDocumentMaterial.update(
            updated: material,
            currentList: allDocumentMaterials
        )
        allDocumentMaterials = updated
    }
    
    func deleteDocumentMaterial(at index: Int) throws {
        guard allDocumentMaterials.indices.contains(index) else {
            throw DocumentMaterialError.writeFailed(reason: "Invalid Document Material Index \(index)")
        }
        let documentMaterialToRemove = allDocumentMaterials[index]
        allDocumentMaterials = try saveDocumentMaterial.delete(
            model: documentMaterialToRemove,
            currentList: allDocumentMaterials
        )
    }
    
    func documentMaterialSearchByID(with materialID: UUID) -> DocumentMaterialModel? {
        allDocumentMaterials.first(where: { $0.id == materialID })
    }
}

