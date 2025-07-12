//
//  InvoiceModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/25/25.
//

import Foundation
/// Struct `InvoiceModel` defines what an invoice consists of.
/// It includes customer info, service details, associated costs, and optional custom fields.
/// Extension to `InvoiceModel` provides sample data for preview/testing.
struct InvoiceModel: Identifiable {
    
    /// Unique identifier for the invoice
    var id: UUID = UUID()
    
    /// Associated customer object
    var customer: CustomerModel
    
    /// Computed ID from the customer for linking
    var customerID: UUID {
        customer.id
    }
    
    /// The business industry this invoice is tied to
    var industryType: IndustryType
    
    /// The type of service( e.g., installation or maintenance))
    var serviceType: ServiceType
    
    /// The structure of the quote (e.g., fixed rate or hourly)
    var quoteType: QuoteType
    
    /// The official date the invoice was generated.
    var invoiceDate: Date?
    
    /// Date of installation if applicable
    var installationDate: Date?
    
    /// Actual service date if applicable
    var serviceDate: Date?
    
    /// Notes related to this invoice
    var notes: String?
    
    /// Cost of subscription if applicable
    var subscriptionTotal: Double?
    
    /// Total cost of materials used
    var materialCost: Double?
    
    /// Total labor charges
    var laborCost: Double?
    
    /// Any extra fees
    var additionalFees: Double?
    
    /// Final amount billed - optional in case you create it manually later
    var totalCost: Double?
    
    /// Optional data for user defined fields.
    var customFields: Data?
    
    // TODO: Make this `Codable` when persistence is added
    // TODO: Create helper functions to handle encoding/decoding `customFields` if used.
}



// Extension for sample data.
extension InvoiceModel {
    static let sample = InvoiceModel(id: UUID(), customer: CustomerModel.sample, industryType: .landscaping, serviceType: .recurring, quoteType: .subscription)
    
    static let sampleList: [InvoiceModel] = [
        .sample,
        InvoiceModel(
            id: UUID(),
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .recurring,
            quoteType: .subscription,
            invoiceDate: Date(),
            totalCost: 750.16
        ),
        InvoiceModel(
            id: UUID(),
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .recurring,
            quoteType: .subscription,
            invoiceDate: Date(),
            totalCost: 3500.97
        ),
        InvoiceModel(
            id: UUID(),
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .recurring,
            quoteType: .subscription,
            invoiceDate: Date(),
            totalCost: 1500.14
        ),
        InvoiceModel(
            id: UUID(),
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .recurring,
            quoteType: .subscription,
            invoiceDate: Date(),
            totalCost: 1200.50
        ),
        InvoiceModel(
            id: UUID(),
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .recurring,
            quoteType: .subscription,
            invoiceDate: Date(),
            totalCost: 5500.65
        ),
    ]
}
