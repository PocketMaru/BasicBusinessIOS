//
//  PressureWashQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct PressureWashQM: Quoteable {
    var materialsUsed: [MaterialExpenseQM]? = nil
    var squareFootageAmount: Double? = 600
    var squareFootRate: Double? = 2
    var solutionType: String? = "Basic Solution"
    var solutionRate: Double? = 0.10
    var solutionQuantity: Double?
    var fixedRate: Double? = 250
    var customer: CustomerModel

    var id: UUID
    var customerID: UUID {
        customer.id
    }
    var industryType: IndustryType = .pressureWashing
    var pricingMethod: PricingMethod
    var quoteDate: Date = Date()
    var notes: String?
    var totalCost: Double {
        switch pricingMethod {
        case .fixedRate:
            guard let fixed = fixedRate else {return 0.0}
            return fixed
        case .squareFootage:
            guard let sqrft = squareFootageAmount,
                  let sqrftRate = squareFootRate,
                  let solRate = solutionRate,
                  let solQty = solutionQuantity else {return 0.0}
            return  (sqrft * sqrftRate) + (solRate * solQty)
        case .subscription, .hourlyRate:
            return 0.0
        case .none:
            return 0.0
        }
    }
}
