//
//  BBQuoteModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

enum QuoteType {
    case fixedRate
    case hourlyRate
    case squareFootage
}
enum ServiceType {
    case installation
    case maintenance
    case repair
    case landscaping
    case pressureWashing
    case consulting
    case handyman
}
struct QuoteModel {
    let id: UUID
    var customerID: CustomerModel
    
    var quoteType: QuoteType
    var serviceType: ServiceType
    
    var fixedRate: Double?
    var hourlyRate: Double?
    var hoursWorked: Double?
    var squareFootRate: Double?
    var squareFootageAmount: Double?
    
    var roofSize: String?
    var installationDate: Date?
    var quoteDate: Date?
    var notes: String?
    
    var totalCost: Double?
}
