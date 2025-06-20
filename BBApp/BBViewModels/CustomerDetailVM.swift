//
//  CustomerDetailVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/11/25.
//

import Foundation

@Observable
class CustomerDetailVM {
    var customer: CustomerModel
    var customerListVM: CustomerListVM
    
    init(customer: CustomerModel, customerListVM: CustomerListVM) {
        self.customer = customer
        self.customerListVM = customerListVM
    }
    
    func saveChanges() {
        customerListVM.updateCustomer(with: customer)
    }
    // Customer Lifetime Value, Last Invoice
    
    // Toggle Fields like isFavorite, isArchived
    
    
}
