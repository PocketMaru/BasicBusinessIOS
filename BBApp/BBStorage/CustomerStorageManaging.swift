//
//  CustomerStorageManaging.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/5/25.
//

import Foundation

protocol SingleCustomerStorageManager {
    func saveCustomer(_ customer: CustomerModel) throws
}
