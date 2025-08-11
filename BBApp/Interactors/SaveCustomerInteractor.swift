//
//  SaveCustomerInteractor.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation
protocol SaveCustomerUseCase {
    func execute(customer: CustomerModel) -> Result<Void, SaveCustomerValidationErrors>
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

struct SaveCustomerInteractor: SaveCustomerUseCase {
    private let fileStorage: SingleCustomerStorageManager
    
    init(fileStorage: SingleCustomerStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func validateInput(customer: CustomerModel) -> [SaveCustomerError] {
        var errors: [SaveCustomerError] = []
        let first = customer.firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let last = customer.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = customer.email.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = customer.phone.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if first.isEmpty {errors.append(.missingFirstName)}
        if last.isEmpty {errors.append(.missingLastName)}
        if email.isEmpty {errors.append(.missingEmail)}
        if phone.isEmpty {errors.append(.missingPhoneNumber)}
        return errors
    }
    
    func execute(customer: CustomerModel) -> Result<Void, SaveCustomerValidationErrors> {
        
        let validationErrors = validateInput(customer: customer)
        if !validationErrors.isEmpty {
            return .failure(SaveCustomerValidationErrors(errors:validationErrors))
        }
        
        do {
            try fileStorage.saveCustomer(customer)
            return .success(())
        } catch {
            return .failure(SaveCustomerValidationErrors(errors: [.writeFailed(reason: String(describing: error))]))
        }
    }
}

