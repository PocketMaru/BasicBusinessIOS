//
//  InvoiceModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/25/25.
//

import Foundation

struct InvoiceModel {
    var id = UUID()
    var customer: CustomerModel
    var customerID: UUID {
        customer.customerID
    }
    var industryType: IndustryType
    var serviceType: ServiceType
    var quoteType: QuoteType
    var quoteDate: Date?
    var installationDate: Date?
    var serviceDate: Date?
    var notes: String?

    var subscriptionTotal: Double?
    var materialCost: Double?
    var laborCost: Double?
    var additionalFees: Double?
    var totalCost: Double?

    var customFields: Data?
}
