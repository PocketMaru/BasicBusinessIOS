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
    var quoteType: QuoteType = .fixedRate
    var quoteDate: Date?
    var notes: String?
    var totalCost: Double? {
        switch quoteType {
        case .fixedRate:
            return fixedRate
        case .hourlyRate, .squareFootage, .subscription:
            return nil
        }
    }
}
