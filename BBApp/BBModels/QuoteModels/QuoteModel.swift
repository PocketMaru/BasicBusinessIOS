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
}
// Quote types
enum QuoteType {
    case fixedRate
    case hourlyRate
    case squareFootage
    case subscription
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
        QuoteModel(customer: CustomerModel.sample, industryType: .landscaping, serviceType: .recurring, quoteType: .subscription),
        QuoteModel(customer: CustomerModel.sample, industryType: .landscaping, serviceType: .maintenance, quoteType: .subscription),
    ]
    
    static func randomSample() -> QuoteModel {
        sampleList.randomElement()!
    }
    
    static func sample(_ index: Int) -> QuoteModel {
        sampleList[index % sampleList.count]
    }
}


