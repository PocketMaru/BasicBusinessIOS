//
//  BBFileManager.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/29/25.
//

import Foundation
protocol CustomerListStorageManager {
    func saveCustomers(_ customers: [CustomerModel]) throws
    func loadCustomers() throws -> [CustomerModel]
}
