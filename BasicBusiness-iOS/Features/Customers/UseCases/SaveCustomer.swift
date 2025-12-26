import Foundation

protocol SaveCustomerUseCase {
    
    func create(
        newCustomer: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel]
    
    func update(
        updated: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel]
    
    func delete(
        customer: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel]
    
    func load() throws -> [CustomerModel]
}

struct SaveCustomer: SaveCustomerUseCase {
    private let filename = "customers.json"
    
    func create(
        newCustomer: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel] {
        if currentList.contains(where: {$0.id == newCustomer.id}) {
            throw SaveError.writeFailed(reason: "Customer with that id already exists")
        }
        let newList = currentList + [newCustomer]
        try FileStorageManager.save(newList, as: filename)
        return newList
    }
    
    func update(
        updated: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel] {
        guard let index = currentList.firstIndex(where: {$0.id == updated.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        var snapshot = currentList
        snapshot[index] = updated
        try FileStorageManager.save(snapshot, as: filename)
        return snapshot
    }
    
    func delete(
        customer: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel] {
        var updatedList = currentList
        guard let index = updatedList.firstIndex(where: { $0.id == customer.id }) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        updatedList.remove(at: index)
        try FileStorageManager.save(updatedList, as: filename)
        return updatedList
    }
    
    func load() throws -> [CustomerModel] {
        try FileStorageManager.load(from: filename)
    }
}




