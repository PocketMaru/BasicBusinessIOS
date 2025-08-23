//
//  SaveCustomerInteractor.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation
protocol SaveCustomerUseCase {
    func create(from draft: CustomerModel, currentList: [CustomerModel]) -> Result<[CustomerModel], SaveCustomerValidationErrors>
    func update(with updated: CustomerModel, currentList: [CustomerModel]) -> Result<[CustomerModel], SaveCustomerValidationErrors>
}

struct SaveCustomer: SaveCustomerUseCase {
    private let fileStorage: CustomerListStorageManager
    
    init (fileStorage: CustomerListStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func create(
        from draft: CustomerModel,
        currentList: [CustomerModel]
    ) -> Result<[CustomerModel], SaveCustomerValidationErrors> {
        let validateResult = validateCustomerInput(customer: draft)
        if !validateResult.isEmpty {
            return .failure(.init(errors: validateResult))
        }
        
        if currentList.contains(where: {$0.id == draft.id}) {
            return .failure(.init(errors: [.writeFailed(reason: "Customer already exists")]))
        }
        
        let newList = currentList + [draft]
        
        do {
            try fileStorage.saveCustomers(newList)
            return .success(newList)
        } catch {
            return .failure(.init(errors: [.writeFailed(reason: error.localizedDescription)]))
        }
    }
    
    func update(
        with updated: CustomerModel,
        currentList: [CustomerModel]
    ) -> Result<[CustomerModel], SaveCustomerValidationErrors> {
        let errs = validateCustomerInput(customer: updated)
        if !errs.isEmpty {
            return .failure(.init(errors: errs))
        }
        
        guard let index = currentList.firstIndex(where: {$0.id == updated.id}) else {
            return .failure(.init(errors: [.writeFailed(reason: "Customer not found")]))
        }
        
        var snapshot = currentList
        snapshot[index] = updated
        
        do {
            try fileStorage.saveCustomers(snapshot)
            return .success(snapshot)
        } catch {
            return .failure(.init(errors: [.writeFailed(reason: error.localizedDescription)]))
        }
    }
}

enum SaveCustomerError: Error {
    case missingFirstName
    case missingLastName
    case missingEmail
    case missingPhoneNumber
    case writeFailed(reason: String)
    
    var message: String {
        switch self {
        case .missingFirstName: return "First name is required."
        case .missingLastName: return "Last name is required."
        case .missingEmail: return "Email is required."
        case .missingPhoneNumber: return "Phone number is required."
        case .writeFailed(let reason): return "Failed to save customer: \(reason)"
        }
    }
}

struct SaveCustomerValidationErrors : Error {
    let errors: [SaveCustomerError]
    
    private func has(_ match: (SaveCustomerError) -> Bool) -> Bool {
        errors.contains(where: match)
    }
    
    var firstName: String? {
        has { if case .missingFirstName = $0 {true} else {false}}
        ? SaveCustomerError.missingFirstName.message : nil
    }
    var lastName: String? {
        has { if case .missingLastName = $0 {true} else {false}}
        ? SaveCustomerError.missingLastName.message : nil
    }
    var email: String? {
        has { if case .missingEmail = $0 {true} else {false}}
        ? SaveCustomerError.missingEmail.message : nil
    }
    var phone: String? {
        has { if case .missingPhoneNumber = $0 {true} else {false}}
        ? SaveCustomerError.missingPhoneNumber.message : nil
    }
    
    var generalMessage: String? {
        if let failed = errors.first(where: {if case .writeFailed = $0 {true} else {false}}) {
            return failed.message
        }
        return nil
    }
}
