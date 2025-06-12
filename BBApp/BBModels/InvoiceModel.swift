//
//  InvoiceModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/25/25.
//

import Foundation

struct InvoiceModel: Identifiable {
    var id: UUID = UUID()
    var customer: CustomerModel
    var customerID: UUID {
        customer.id
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
// Extension for sample data.
extension InvoiceModel {
    static let sample = InvoiceModel(id: UUID(), customer: CustomerModel.sample, industryType: .landscaping, serviceType: .recurring, quoteType: .subscription)
    
    static let sampleList: [InvoiceModel] = [
        .sample,
        InvoiceModel(id: UUID(), customer: CustomerModel.sample, industryType: .landscaping, serviceType: .recurring, quoteType: .subscription),
        InvoiceModel(id: UUID(), customer: CustomerModel.sample, industryType: .landscaping, serviceType: .recurring, quoteType: .subscription),
    ]
}
