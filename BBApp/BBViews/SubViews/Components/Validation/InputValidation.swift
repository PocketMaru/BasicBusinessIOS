//
//  InputValidation.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/20/25.
//

import Foundation

// Currently just an empty check, more formatting of user
// input to come.
func validateCustomerInput(customer: CustomerModel) -> [SaveCustomerError] {
    var errors: [SaveCustomerError] = []
    let first = customer.firstName.trimmingCharacters(in: .whitespacesAndNewlines)
    let last = customer.lastName.trimmingCharacters(in: .whitespacesAndNewlines)
    let email = customer.email.trimmingCharacters(in: .whitespacesAndNewlines)
    let phone = customer.phone.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if first.isEmpty {errors.append(.missingFirstName)}
    if last.isEmpty {errors.append(.missingLastName)}
    if email.isEmpty {errors.append(.missingEmail)}
    if phone.isEmpty {errors.append(.missingPhoneNumber)}
    return errors
}
