//
//  CustomerVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation
@Observable
final class CustomerListVM {
    var allCustomers: [CustomerModel] = []
    var allQuotes: [QuoteModel] = []
    
    init(customers: [CustomerModel]) {
        self.allCustomers = customers
    }
    
    func addCustomer(
        firstName: String,
        lastName: String,
        email: String,
        address: String?,
        phone: String,
        paidBill: Bool?
    ){
        let newCustomer = CustomerModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            phone: phone,
            paidBill: paidBill ?? false
        )
        allCustomers.append(newCustomer)
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
    }
    
    func showAllCustomerQuotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
    
    func updateCustomer(with updated: CustomerModel) {
        if let index = allCustomers.firstIndex(where: { $0.id == updated.id }) {
            allCustomers[index] = updated
        }
    }
}
