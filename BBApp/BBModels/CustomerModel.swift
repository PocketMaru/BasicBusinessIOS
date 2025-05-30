//
//  CustomerModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/6/25.
//

import Foundation
import Observation


// Customer model outlining the data that exists within a customer.
struct CustomerModel {
    // Variables that make up our customer model
    let customerID = UUID()
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var address: String? = nil
    var phone: String = ""
    var paidBill: Bool? = false
    
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
}
