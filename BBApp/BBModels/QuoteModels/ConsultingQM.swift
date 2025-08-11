//
//  ConsultingQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct ConsultingQM: Quoteable {
    var materialsUsed: [MaterialExpenseQM]? = nil
    var hoursWorked: Double? = 1
    var hourlyRate: Double? = 50
    var customer: CustomerModel
    var fixedRate: Double? = 100
    
    var id: UUID
    var customerID: UUID {
        customer.id
    }
    var industryType: IndustryType = .consulting
    var pricingMethod: PricingMethod
    var quoteDate: Date = Date()
    var notes: String?
    var totalCost: Double? {
        switch pricingMethod {
            case .fixedRate:
            return fixedRate
        case .hourlyRate:
            guard let hoursWorked = hoursWorked,
                  let hourlyRate = hourlyRate else {return nil}
            return hoursWorked * hourlyRate
        case .squareFootage, .subscription:
            return nil
        }
    }
}
