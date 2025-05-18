//
//  LPCustomerModel.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import Foundation
import Observation

@Observable
// Customer model outlining the data that exists within a customer.
class BBCustomerModel {
    // Variables that make up our customer model
    let customerID = UUID()
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var address: String = ""
    var phone: String = ""
    var paidBill: Bool? = false
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    // First initializer, used for when we want to create a instance of this class with specific values.
    init(firstName: String, lastName: String, email: String, address: String, phone: String, paidBill: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.phone = phone
        self.paidBill = paidBill
    }
    // Custom initializer for full control when passing in real values.
    // Used for new entries, and placeholder data.
    init(){
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.address = ""
        self.phone = ""
        self.paidBill = false
    }
}
