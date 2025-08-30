//
//  SaveCustomerInteractor.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation
protocol SaveCustomerUseCase {
    func create(from newCustomer: CustomerModel, currentList: [CustomerModel]) throws -> [CustomerModel]
    func update(with updated: CustomerModel, currentList: [CustomerModel]) throws -> [CustomerModel]
}

struct SaveCustomer: SaveCustomerUseCase {
    private let fileStorage: CustomerListStorageManager
    
    init (fileStorage: CustomerListStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func create(
        from newCustomer: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel] {
        
        let newList = currentList + [newCustomer]
        
        try fileStorage.saveCustomers(newList)
        return newList
    }
    
    func update(
        with updated: CustomerModel,
        currentList: [CustomerModel]
    ) throws -> [CustomerModel] {
        
        guard let index = currentList.firstIndex(where: {$0.id == updated.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        
        var snapshot = currentList
        snapshot[index] = updated
        
        try fileStorage.saveCustomers(snapshot)
        return snapshot
    }
    
    // TODO: Write a delete function, remove the delete function from the VM
}




