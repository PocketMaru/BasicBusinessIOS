//
//  HandymanQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct HandymanQM: Quoteable {
    var materialsUsed: [MaterialExpenseQM]? = nil
    var squareFootage: Double? = 600
    var squareFootageRate: Double? = 25
    var hoursWorked: Double? = 10
    var hourlyRate: Double? = 50
    var fixedRate: Double? = 100
    var customer: CustomerModel
    var totalMaterialCost: Double {
        guard let materials = materialsUsed else {return 0}
        return materials.reduce(0) {$0 + ($1.unitCost * Double($1.quantityUsed))}
    }
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    var industryType: IndustryType = .landscaping
    var quoteType: QuoteType = .fixedRate
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        let materialTotal = totalMaterialCost
        switch quoteType {
            
        case .fixedRate:
            return fixedRate
        case .hourlyRate:
            guard let hourlyRate = hourlyRate,
                  let hoursWorked = hoursWorked else { return nil }
            return hourlyRate * hoursWorked
        case .squareFootage:
            guard let sqrft = squareFootage,
                  let sqrftRate = squareFootageRate else { return nil }
            return (sqrft * sqrftRate) + totalMaterialCost
        case .subscription:
            return nil
        }
    }
}
