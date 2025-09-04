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
        let vm = CustomerFormVM(
            customer: customer,
            mode: .edit,
            saveUseCase: saveCustomer,
            onSubmit: { [weak self] draft in
               try self?.updateCustomer(from: draft)
            }
        )
        return vm
    }
    
    func addVM() -> CustomerFormVM {
        print("Creating AddVM for new customer")
        let vm = CustomerFormVM(
            customer: CustomerModel(),
            mode: .add,
            saveUseCase: saveCustomer,
            onSubmit: { [weak self] draft in
               try self?.addCustomer(from: draft)
            }
        )
        return vm
    }
    
    init() {
        self.customerListStorage = FileStorageManager()
        self.saveCustomer = SaveCustomer(fileStorage: customerListStorage)
        
        do {
            self.allCustomers = try customerListStorage.loadCustomers()
        } catch(let e) {
            print(e)
            self.allCustomers = []
        }
    }
    
    func addCustomer(from draft: CustomerModel) throws {
        let newCustomer = try saveCustomer.create(from: draft, currentList: allCustomers)
        allCustomers = newCustomer
    }
    
    func updateCustomer(from draft: CustomerModel) throws {
        guard let _ = allCustomers.firstIndex(where: { $0.id == draft.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        let updated = try saveCustomer.update(with: draft, currentList: allCustomers)
        allCustomers = updated
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
            print("Invalid index \(index) for removal")
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
}
