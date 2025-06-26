//
//  QuoteModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation
// Global quote expectations.
protocol Quoteable {
    var id: UUID {get}
    var customerID: UUID {get}
    var industryType: IndustryType {get}
    var quoteType: QuoteType {get}
    var quoteDate: Date? {get}
    var notes: String? {get}
    var totalCost: Double? {get}
}
// Industry types
enum IndustryType: String, CaseIterable, Identifiable {
    case landscaping
    case pressureWashing
    case consulting
    case handyman
    case HVAC
    case productSales
    
    var id: String {self.rawValue}
    
    var displayName: String {
        switch self {
        case .landscaping:
            return "Landscaping"
        case .pressureWashing:
            return "Pressure Washing"
        case .consulting:
            return "Consulting"
        case .handyman:
            return "Handyman"
        case .HVAC:
            return "HVAC"
        case .productSales:
            return "Product Sales"
        }
    }
}
// Service types
enum ServiceType {
    case installation
    case maintenance
    case repair
    case recurring
    case custom(String)
    
    var name: String {
        switch self {
        case .installation:
            return "Installation"
        case .maintenance:
            return "Maintenance"
        case .repair:
            return "Repair"
        case .recurring:
            return "Recurring"
        case .custom(let name):
            return name
        }
    }
}
// Quote types
enum QuoteType {
    case fixedRate
    case hourlyRate
    case squareFootage
    case subscription
    
    var name: String {
        switch self {
        case .fixedRate:
            return "Fixed Rate"
        case .hourlyRate:
            return "Hourly Rate"
        case .squareFootage:
            return "Square Footage"
        case .subscription:
            return "Subscription"
        }
    }
}

struct QuoteModel: Identifiable, Quoteable {
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
    
    var materialExpenses: [MaterialExpenseQM] = []
    var materialTotalCost: Double? {
        materialExpenses.reduce(0) { $0 + $1.unitCost }
    }
    var pendingExpenses: [MaterialExpensePreview] = []
}
// Extension for sample data.
extension QuoteModel {
    static let sample = QuoteModel(
        customer: .sample,
        industryType: .landscaping,
        serviceType: .installation,
        quoteType: .fixedRate,
        notes: "This is a sample quote."
    )
    
    static let sampleList: [QuoteModel] = [
        .sample,
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .landscaping,
            serviceType: .maintenance,
            quoteType: .subscription,
            totalCost: 300),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .pressureWashing,
            serviceType: .maintenance,
            quoteType: .fixedRate,
            totalCost: 3000),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .HVAC,
            serviceType: .maintenance,
            quoteType: .fixedRate,
            totalCost: 1000),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .consulting,
            serviceType: .custom("Consulting Services"),
            quoteType: .fixedRate,
            totalCost: 250),
        QuoteModel(
            customer: CustomerModel.sample,
            industryType: .handyman,
            serviceType: .maintenance,
            quoteType: .fixedRate,
            totalCost: 3000),
    ]
}


