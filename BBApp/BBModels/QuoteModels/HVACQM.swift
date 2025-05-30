//
//  HVACQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation

struct HVACQM {
    var materialUsed: [MaterialExpenseQM]? = nil
    var hoursWorked: Double? = 0
    var hourlyRate: Double? = 100
    var fixedRate: Double? = 250
    var customer: CustomerModel
    
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    
    var industryType: IndustryType = .HVAC
    var quoteType: QuoteType = .fixedRate
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        switch quoteType {
        case .fixedRate:
            return fixedRate
        case .hourlyRate:
            guard let hourlyRate = hourlyRate, let hoursWorked = hoursWorked else { return nil }
            return hourlyRate * hoursWorked
        case .subscription, .squareFootage:
            return nil
        }
    }
    
    
    
    
}
