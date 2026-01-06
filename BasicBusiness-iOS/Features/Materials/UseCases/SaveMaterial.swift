import Foundation

protocol SaveMaterialUseCase {
    
    func create(
        draft: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel]
    
    func update(
        material: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel]
    
    func delete(
        material: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel]
    
    func load() throws -> [MaterialModel]
}

final class SaveMaterial: SaveMaterialUseCase {
    private let filename = "materials.json"
    
    func create(
        draft: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel] {
        if currentList.contains(where: { $0.id == draft.id }) {
            throw SaveError.writeFailed(reason: "Duplicate Material ID")
        }
        let updatedList = currentList + [draft]
        try FileStorageManager.save(updatedList, as: filename)
        return updatedList
    }
    
    func update(
        material: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel] {
        var snapShot = currentList
        guard let index = snapShot.firstIndex(where: {$0.id == material.id})
        else {
            throw SaveError.writeFailed(reason: "Material Not Found")
        }
        snapShot[index] = material
        try FileStorageManager.save(snapShot, as: filename)
        return snapShot
    }
    
    func delete(
        material: MaterialModel,
        currentList: [MaterialModel]
    ) throws -> [MaterialModel] {
        var updatedList = currentList
        guard let index = updatedList.firstIndex(where: {$0.id == material.id}) else {
            throw SaveError.writeFailed(reason: "Material not found")
        }
        updatedList.remove(at: index)
        try FileStorageManager.save(updatedList, as: filename)
        return updatedList
    }
    
    func load() throws -> [MaterialModel] {
        try FileStorageManager.load(from: filename)
    }
}

