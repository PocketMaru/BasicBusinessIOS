//
//  LandscapeQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct LandscapeQM: Quoteable {
    var squareFootageAmount: Double?
    var squareFootRate: Double?
    var fixedRate: Double?
    var subscription: Double?
    var customer: CustomerModel
    
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    var industryType: IndustryType = .landscaping
    var quoteType: QuoteType = .fixedRate
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        switch quoteType {
        case .fixedRate:
            return fixedRate
        case .squareFootage:
            guard let sqrft = squareFootageAmount,
                  let rate = squareFootRate else {return nil}
            return sqrft * rate
        case .subscription:
            return subscription
        case .hourlyRate:
            return nil
        }
    }
}
