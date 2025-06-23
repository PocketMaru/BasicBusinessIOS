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
    var onSave: ((CustomerModel)-> Void)? = nil
    
    init(customer: CustomerModel, onSave: ((CustomerModel)-> Void)? = nil) {
        self.customer = customer
    }
    
    func saveChanges() {
        onSave?(customer)
    }
    // Customer Lifetime Value, Last Invoice
    
    // Toggle Fields like isFavorite, isArchived
    
    
}
