//
//  ProductSales.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation

struct ProductSalesQM {
    var materialsUsed: [MaterialExpenseQM]? = nil
    var fixedRate: Double? = 100
    var customer: CustomerModel
    var id: UUID
    var customerID: UUID {
        customer.id
    }
    
    var industryType: IndustryType = .productSales
    var quoteType: PricingMethod = .fixedRate
    var quoteDate: Date = Date()
    var notes: String?
    var totalCost: Double {
        switch quoteType {
        case .fixedRate:
            guard let fixed = fixedRate else {return 0.0}
            return fixed
        case .hourlyRate, .squareFootage, .subscription:
            return 0.0
        case .none:
            return 0.0
        }
    }
}
