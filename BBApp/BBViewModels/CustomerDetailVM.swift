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
    
    init(customer: CustomerModel) {
        self.customer = customer
    }
    
    // Update Name
    func updateName(_ newName: String) {
        customer.firstName = newName
    }
    // Update Phone
    func updatePhone(_ newPhone: String) {
        customer.phone = newPhone
    }
    // Update Email
    func updateEmail(_ newEmail: String) {
        customer.email = newEmail
    }
    // Update Address
    func updateAddress(_ newAddress: String) {
        customer.address = newAddress
    }
    // Mark as Paid
    func markAsPaid() {
        customer.paidBill = true
    }
    // Customer Lifetime Value, Last Invoice
    
    // Toggle Fields like isFavorite, isArchived
    
    
}
