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
    
    var paidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill == true }
    }
    var unpaidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill == false }
    }
    
    private let saveCustomer: SaveCustomerUseCase
    private let customerListStorage: CustomerListStorageManager
    private var formVMCache: [UUID: CustomerFormVM] = [:]
    
    func detailVM(for customer: CustomerModel) -> CustomerFormVM {
        if let vm = formVMCache[customer.id] {
            print("✅ cache HIT for \(customer.id)")
            return vm
        }
        print("🆕 cache MISS → creating VM for \(customer.id)")
        let vm = CustomerFormVM(
            customer: customer,
            mode: .edit,
            saveUseCase: saveCustomer
        )
        formVMCache[customer.id] = vm
        return vm
    }
    
    init(saveCustomer: SaveCustomerUseCase, customerListStorage: CustomerListStorageManager) {
        self.saveCustomer = saveCustomer
        self.customerListStorage = customerListStorage
        self.allCustomers = (try? customerListStorage.loadCustomers()) ?? []
    }
    
    @discardableResult
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

        let result = saveCustomer.executeSaveNewCustomer(
            newCustomer: newCustomer,
            currentList: allCustomers
        )
            
            switch result {
            case .success(let newList):
                allCustomers = newList
                _ = handleValidationResult(.success(()),successMessage: "Customer added successfully")
                return true
            case .failure:
                _ = handleValidationResult(result,successMessage: "")
                return false
            }
    }
    
    @discardableResult
    func updateCustomer(with updated: CustomerModel) -> Bool {
        let result = saveCustomer.executeUpdateCustomer(updated: updated, currentList: allCustomers)
        
        switch result {
        case .success(let newList):
            allCustomers = newList
            _ = handleValidationResult(.success(()),successMessage: "Customer updated successfully")
            return true
            
        case .failure:
            _ = handleValidationResult(result,successMessage: "")
            return false
        }
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
        let removed = allCustomers[index]
        formVMCache[removed.id] = nil
        allCustomers.remove(at: index)
        try? customerListStorage.saveCustomers(allCustomers)
    }

    func showAllCustomerQuotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
    
    func handleValidationResult<T> (
        _ result: Result<T, SaveCustomerValidationErrors>,
        successMessage: String
    ) -> Bool {
        
        switch result {
        case .success:
            statusMessage = successMessage
            return true
            
        case .failure:
            statusMessage = "Please fix the highlighted fields."
            return false
        }
    }
}
