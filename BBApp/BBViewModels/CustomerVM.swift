//
//  BBCustomerViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation
@Observable
final class CustomerVM {
    var customer: [CustomerModel] = []
    
    init(customer: [CustomerModel]) {
        self.customer = customer
    }
    
    func addCustomer(
        firstName: String,
        lastName: String,
        email: String,
        address: String,
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
        customer.append(newCustomer)
    }
    
    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        return customer.filter {
            $0.firstName.lowercased().contains(query) ||
            $0.lastName.lowercased().contains(query) ||
            "\($0.firstName) \($0.lastName)".lowercased().contains(query)
        }
    }
    
    func removeCustomer(at index: Int){
        customer.remove(at: index)
    }
}
