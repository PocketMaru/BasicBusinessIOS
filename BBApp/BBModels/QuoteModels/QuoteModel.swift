//
//  BBQuoteModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation
// Data all quotes will have
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
enum IndustryType {
    case landscaping
    case pressureWashing
    case consulting
    case handyman
    case HVAC
    case productSales
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

struct QuoteModel: Quoteable {
    var id = UUID()
    var customerID: UUID
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
