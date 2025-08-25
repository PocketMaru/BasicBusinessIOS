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
    
    func editVM(for customer: CustomerModel) -> CustomerFormVM {
        print("cache MISS → creating VM for \(customer.id)")
        return CustomerFormVM(
            customer: customer,
            mode: .edit,
            saveUseCase: saveCustomer,
            setStatusMessage: { [weak self] msg in self?.statusMessage = msg },
            onSubmit: { [weak self] draft in
                self?.updateCustomer(from: draft) ?? .failure(.init(errors: [.writeFailed(reason: "Unknown error")]))
            }
        )
    }
    
    func addVM() -> CustomerFormVM {
        let newCustomer = CustomerModel()
        print("Creating AddVM for new customer")
        return CustomerFormVM(
            customer: newCustomer,
            mode: .add,
            saveUseCase: saveCustomer,
            setStatusMessage: { [weak self] msg in self?.statusMessage = msg },
            onSubmit: { [weak self] draft in
                guard let self else {
                    return .failure(.init(errors: [.writeFailed(reason: "Unknown error")]))
                }
                let result = self.addCustomer(from: draft)
                return result
            }
        )
    }
    
    init(saveCustomer: SaveCustomerUseCase, customerListStorage: CustomerListStorageManager) {
        self.saveCustomer = saveCustomer
        self.customerListStorage = customerListStorage
        self.allCustomers = (try? customerListStorage.loadCustomers()) ?? []
    }
    
    @discardableResult
    func addCustomer(from draft: CustomerModel) -> Result<Void, SaveCustomerValidationErrors>  {
        let result = saveCustomer.create(from: draft, currentList: allCustomers)
        
        switch result {
        case .success(let updated):
            allCustomers = updated
            return .success(())
        case .failure(let errors):
            return .failure(errors)
        }
    }
    
    @discardableResult
    func submitNewCustomer(from draft: CustomerModel) -> Bool {
        handleValidationResult(addCustomer(from: draft), successMessage: "Customer added successfully.")
    }
    
    @discardableResult
    func updateCustomer(from draft: CustomerModel) -> Result<Void, SaveCustomerValidationErrors> {
        let result = saveCustomer.update(with: draft, currentList: allCustomers)
        
        switch result {
        case .success(let newList):
            allCustomers = newList
            return .success(())
        case .failure(let errors):
            return .failure(errors)
        }
    }
    
    @discardableResult
    func submitCustomerEdits(from draft: CustomerModel) -> Bool {
        handleValidationResult(updateCustomer(from: draft), successMessage: "Customer updated successfully.")
    }

    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        return allCustomers.filter {
            $0.firstName.lowercased().contains(query) ||
            $0.lastName.lowercased().contains(query) ||
            "\($0.firstName) \($0.lastName)".lowercased().contains(query)
        }
    }

    func removeCustomer(at index: Int) {
        guard allCustomers.indices.contains(index) else {
            print("⚠️ Invalid index \(index) for removal")
            return
        }

        let removed = allCustomers.remove(at: index)
        do {
            try customerListStorage.saveCustomers(allCustomers)
            print("Removed customer \(removed.id) and saved list")
        } catch {
            print("Failed to save customers after removal: \(error)")
        }
    }

    func showAllCustomerQuotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
    
    func handleValidationResult (
        _ result: Result<Void, SaveCustomerValidationErrors>,
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
