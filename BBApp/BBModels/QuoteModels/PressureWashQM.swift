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
    var totalMaterialCost: Double {
        guard let materials = materialsUsed else {return 0}
        return materials.reduce(0) { $0 + ($1.unitCost * Double($1.quantityUsed)) }
    }
    var id: UUID
    var customerID: UUID {
        customer.customerID
    }
    var industryType: IndustryType = .pressureWashing
    var quoteType: QuoteType
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        let materialTotal = totalMaterialCost
        switch quoteType {
        case .fixedRate:
            return (fixedRate ?? 0) + (materialTotal)
        case .squareFootage:
            guard let sqrft = squareFootageAmount,
                  let sqrftRate = squareFootRate,
                  let solRate = solutionRate,
                  let solQty = solutionQuantity else {return nil}
            return  (sqrft * sqrftRate) + (solRate * solQty) + materialTotal
        case .subscription, .hourlyRate:
            return nil
        }
    }
}
