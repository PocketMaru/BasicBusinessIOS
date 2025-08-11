//
//  CustomerVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

@MainActor
@Observable
final class CustomerListVM {
    var allCustomers: [CustomerModel] = []
    var allQuotes: [QuoteModel] = []
    
    var statusMessage: String?
    
    var firstNameError: String?
    var lastNameError: String?
    var emailError: String?
    var phoneError: String?
    var generalError: String?
    
    var paidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill == true }
    }
    
    var unpaidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill != true }
    }
    
    private let saveCustomer: SaveCustomerUseCase
    
    private let customerListStorage: CustomerListStorageManager
    
    init(saveCustomer: SaveCustomerUseCase, customerListStorage: CustomerListStorageManager) {
        self.saveCustomer = saveCustomer
        self.customerListStorage = customerListStorage
        self.allCustomers = (try? customerListStorage.loadCustomers()) ?? []
    }
    
    func addCustomer(
        firstName: String,
        lastName: String,
        email: String,
        address: String?,
        zipCode: String?,
        phone: String,
        paidBill: Bool?,
        loyaltyDate: Date = Date()
    ) -> Bool {
        
        let newCustomer = CustomerModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            zipCode: zipCode,
            phone: phone,
            paidBill: paidBill ?? false,
            loyaltyDate: loyaltyDate
        )
        
        let result = saveCustomer.execute(customer: newCustomer)
        
        if handleValidationResult(result, successMessage: "Customer added successfully!") {
            allCustomers.append(newCustomer)
            try? customerListStorage.saveCustomers(allCustomers)
            return true
        }
        return false
    }
    
    func updateCustomer(with updated: CustomerModel) -> Bool {
        guard let index = allCustomers.firstIndex(where: { $0.id == updated.id }) else {
            return false
        }
        
        let result = saveCustomer.execute(customer: updated)
        
        if handleValidationResult(result, successMessage: "Customer edited successfully!") {
            let oldCustomer = allCustomers[index]
            allCustomers[index] = updated
            do {
                try customerListStorage.saveCustomers(allCustomers)
                return true
            } catch {
                allCustomers[index] = oldCustomer
                _ = handleValidationResult(.failure(.init(errors: [.writeFailed(reason: error.localizedDescription)])), successMessage: "")
            }
        }
        return false
    }
    
    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        return allCustomers.filter {
            $0.firstName.lowercased().contains(query) ||
            $0.lastName.lowercased().contains(query) ||
            "\($0.firstName) \($0.lastName)".lowercased().contains(query)
        }
    }
    
    func removeCustomer(at index: Int){
        allCustomers.remove(at: index)
        try? customerListStorage.saveCustomers(allCustomers)
    }
    
    func showAllCustomerQuotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
    
    func clearErrorMessages() {
        firstNameError = nil
        lastNameError = nil
        emailError = nil
        phoneError = nil
        generalError = nil
    }
    
    private func handleValidationResult (
        _ result: Result<Void, SaveCustomerValidationErrors>,
        successMessage: String
    ) -> Bool {
        clearErrorMessages()
        
        switch result {
        case .success:
            statusMessage = successMessage
            return true
            
        case .failure(let validationErrors):
            for error in validationErrors.errors {
                switch error {
                case .missingFirstName:
                    firstNameError = error.message
                case .missingLastName:
                    lastNameError = error.message
                case .missingEmail:
                    emailError = error.message
                case .missingPhoneNumber:
                    phoneError = error.message
                case .writeFailed:
                    generalError = error.message
                }
            }
            return false
        }
        
    }
}
