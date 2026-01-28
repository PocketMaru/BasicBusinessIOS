import Foundation

struct ModelStorageUseCase<Model: Codable & Identifiable> where Model.ID == UUID {
    let filename: String
    
    func create(
        newModel: Model,
        currentList: [Model]
    ) throws -> [Model] {
        if currentList.contains(where: {$0.id == newModel.id}) {
            throw SaveError.writeFailed(reason: "Model with that id already exists")
        }
        let newList = currentList + [newModel]
        try FileStorageManager.save(newList, as: filename)
        return newList
    }
    
    func update(
        updated: Model,
        currentList: [Model]
    ) throws -> [Model] {
        guard let index = currentList.firstIndex(where: {$0.id == updated.id}) else {
            throw SaveError.writeFailed(reason: "Model not found")
        }
        var snapshot = currentList
        snapshot[index] = updated
        try FileStorageManager.save(snapshot, as: filename)
        return snapshot
    }
    
    func delete(
        model: Model,
        currentList: [Model]
    ) throws -> [Model] {
        var updatedList = currentList
        guard let index = updatedList.firstIndex(where: { $0.id == model.id }) else {
            throw SaveError.writeFailed(reason: "Model not found")
        }
        updatedList.remove(at: index)
        try FileStorageManager.save(updatedList, as: filename)
        return updatedList
    }
    
    func load() throws -> [Model] {
        try FileStorageManager.load(from: filename)
    }
}
