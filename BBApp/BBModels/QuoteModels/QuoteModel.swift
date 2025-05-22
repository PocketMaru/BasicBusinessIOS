//
//  BBQuoteModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

protocol Quoteable {
    var id: UUID {get}
    var customerID: UUID {get}
    var serviceType: ServiceType {get}
    var quoteDate: Date? {get}
    var notes: String? {get}
    var totalCost: Double? {get}
}

final class LawnCareQuote: Quoteable {
    var squareFootageAmount: Double?
    var squareFootRate: Double?
    var fixedRate: Double?
    var customer: CustomerModel
    
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    var serviceType: ServiceType = .landscaping
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        if let fixed = fixedRate {
            return fixed
        } else if let sqft = squareFootageAmount, let sqftRate = squareFootRate {
            return sqft * sqftRate
        } else {
            return nil
        }
    }
    
    init(
        squareFootageAmount: Double? = nil,
        squareFootRate: Double? = nil,
        fixedRate: Double? = nil,
        customer: CustomerModel,
        id: UUID,
        serviceType: ServiceType,
        quoteDate: Date? = nil,
        notes: String? = nil
    ) {
        self.squareFootageAmount = squareFootageAmount
        self.squareFootRate = squareFootRate
        self.fixedRate = fixedRate
        self.customer = customer
        self.id = id
        self.serviceType = serviceType
        self.quoteDate = quoteDate
        self.notes = notes
    }
    
    
}
final class PressureWashingQuote: Quoteable {
    var squareFootageAmount: Double?
    var squareFootRate: Double?
    var solutionType: String?
    var solutionRate: Double?
    var solutionQuantity: Double?
    var fixedRate: Double?
    var customer: CustomerModel
    
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    var serviceType: ServiceType
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        if let fixed = fixedRate {
            return fixed
        } else if
            let squareFootageAmount = squareFootageAmount,
                let squareFootRate = squareFootRate,
                let solutionQuantity = solutionQuantity,
                let solutionRate = solutionRate {
            return squareFootRate * squareFootageAmount + solutionRate * solutionQuantity
        } else {
            return nil
        }
    }
    
}
struct ConsultingQuote {
    
}
struct HandymanQuote {
    
}
struct HVACQuote {
    
}
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

final class QuoteModel {
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
    
    var materialCost: Double?
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
         
         materialCost: Double? = nil,
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
        
        self.materialCost = materialCost
        self.totalCost = totalCost
    }
}
