//
//  LawnProTests.swift
//  LawnProTests
//
//  Created by Joshua Hauer on 5/4/25.
//

import Testing
@testable import BasicBusiness

@MainActor
struct BasicBusinessTests {

    @Test func customerDependencyInjectionWorks() async throws {
        let mockStorage = InMemoryCustomerStorage()
        let saveCustomer = SaveCustomerInteractor(fileStorage: mockStorage)
        
        let customerListVM = CustomerListVM(
            saveCustomer: saveCustomer,
            customerListStorage: mockStorage
            )
        
        let customerDetailVM = CustomerFormVM(
            customer: CustomerModel(),
            saveUseCase: saveCustomer,
            )
        
        _ = customerListVM.addCustomer(
            firstName: "John",
            lastName: "Doe",
            email: "johndoe@example.com",
            address: "123 Main St",
            zipCode: "12345",
            phone: "123-456-7890",
            paidBill: false
        )
        
        #expect(customerListVM.allCustomers.count == 1)
        #expect(customerListVM.allCustomers.first?.firstName == "John")
        
        if let firstCustomer = customerListVM.allCustomers.first {
            customerDetailVM.draft = firstCustomer
            customerDetailVM.draft.firstName = "Johnny"
            _ = customerDetailVM.saveChanges(successMessage: "Customer saved successfully!")
        }
        
        #expect(customerListVM.allCustomers.first?.firstName == "Johnny")
    }

}

final class InMemoryCustomerStorage: CustomerListStorageManager, SingleCustomerStorageManager {
    private var customers: [CustomerModel] = []
    
    func saveCustomer(_ customer: CustomerModel) throws {
        if let index = customers.firstIndex(of: customer) {
            customers[index] = customer
        } else {
            customers.append(customer)
        }
    }
    
    func saveCustomers(_ customers: [CustomerModel]) throws {
        self.customers = customers
    }
    
    func loadCustomers() throws -> [CustomerModel] {
        return customers
    }
}
