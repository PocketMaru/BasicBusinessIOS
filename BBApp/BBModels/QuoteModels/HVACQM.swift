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
        customer.id
    }
    
    var industryType: IndustryType = .HVAC
    var quoteType: PricingMethod = .fixedRate
    var quoteDate: Date = Date()
    var notes: String?
    var totalCost: Double {
        switch quoteType {
        case .fixedRate:
            guard let fixed = fixedRate else { return 0.0 }
            return fixed
        case .hourlyRate:
            guard let hourlyRate = hourlyRate, let hoursWorked = hoursWorked else { return 0.0 }
            return hourlyRate * hoursWorked
        case .subscription, .squareFootage:
            return 0.0
        case .none:
            return 0.0
        }
    }
    
    
    
    
}
