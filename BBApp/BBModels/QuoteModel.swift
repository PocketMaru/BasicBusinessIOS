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
class QuoteModel {
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
    
    init(
         id: UUID,
         customerID: CustomerModel,
         quoteType: QuoteType,
         serviceType: ServiceType,
         fixedRate: Double? = nil,
         hourlyRate: Double? = nil,
         hoursWorked: Double? = nil,
         squareFootRate: Double? = nil,
         squareFootageAmount: Double? = nil,
         roofSize: String? = nil,
         installationDate: Date? = nil,
         quoteDate: Date? = nil,
         notes: String? = nil,
         totalCost: Double? = nil
    ) {
        self.id = id
        self.customerID = customerID
        self.quoteType = quoteType
        self.serviceType = serviceType
        self.fixedRate = fixedRate
        self.hourlyRate = hourlyRate
        self.hoursWorked = hoursWorked
        self.squareFootRate = squareFootRate
        self.squareFootageAmount = squareFootageAmount
        self.roofSize = roofSize
        self.installationDate = installationDate
        self.quoteDate = quoteDate
        self.notes = notes
        self.totalCost = totalCost
    }
}
