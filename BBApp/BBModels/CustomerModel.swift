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
    var zipCode: String? = nil
    var paidBill: Bool? = false
    
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
}
// Extension for sample data.
extension CustomerModel {
    static let sample = CustomerModel(
        firstName: "John",
        lastName: "Doe",
        email: "johndoe@example.com",
        phone: "(123) 456-7890"
    )
    
    static let sampleList: [CustomerModel] = [
        .sample,
        CustomerModel(firstName: "Joshua", lastName: "Hauer", email: "joshuahauer@icloud.com", address: "43 Ginger Circle", phone: "352-272-2099", zipCode: "34748", paidBill: false),
        CustomerModel(firstName: "Kaley", lastName: "Hauer", email: "Kaleyhauer@icloud.com", address: "43 Ginger Circle", phone: "408-808-2843", zipCode: "34748", paidBill: false),
        CustomerModel(firstName: "Raven", lastName: "Hauer", email: "ravenhauer@icloud.com", address: "43 Ginger Circle", phone: "444-555-6666", zipCode: "34748", paidBill: false),
        CustomerModel(firstName: "Valkyrie", lastName: "Hauer", email: "valkyriehauer@icloud.com", address: "43 Ginger Circle", phone: "333-222-1111", zipCode: "34748", paidBill: false),
        CustomerModel(firstName: "Goose", lastName: "BABA", email: "goosebaba@icloud.com", address: "43 Ginger Circle", phone: "111-222-3333", zipCode: "34748", paidBill: false)
    ]
    
    static func randomSample() -> CustomerModel {
        sampleList.randomElement()!
    }
    
    static func sample(_ index: Int) -> CustomerModel {
        sampleList[index % sampleList.count]
    }
}
