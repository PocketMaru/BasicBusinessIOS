//
//  LandscapeQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct LandscapeQM: Quoteable {
    var materialsUsed: [MaterialExpenseQM]? = nil
    var squareFootageAmount: Double?
    var squareFootRate: Double?
    var fixedRate: Double?
    var subscription: Double?
    var customer: CustomerModel
    var id: UUID
    var customerID: UUID {
        customer.id
    }
    var industryType: IndustryType = .landscaping
    var serviceType: ServiceType = .none
    var pricingMethod: PricingMethod = .fixedRate
    var quoteDate: Date = Date()
    var notes: String?
    var totalCost: Double {
        switch pricingMethod {
        case .fixedRate:
            guard let fixed = fixedRate else {return 0.0}
            return fixed
        case .squareFootage:
            guard let sqrft = squareFootageAmount,
                  let rate = squareFootRate else {return 0.0}
            return sqrft * rate
        case .subscription:
            guard let sub = subscription else {return 0.0}
            return sub
        case .hourlyRate:
            return 0.0
        case .none:
            return 0.0
        }
    }
    func toQuoteModel() -> QuoteModel {
        QuoteModel(id: self.id, customer: self.customer, industryType: self.industryType, serviceType: self.serviceType, pricingMethod: self.pricingMethod, quoteDate: self.quoteDate, notes: self.notes, totalCost: self.totalCost, customFields: [
            CustomField(label: "Suare Footage Amount", value: "\(self.squareFootageAmount ?? 0.0)"),
            CustomField(label: "Square Foot Rate", value: "\(self.squareFootRate ?? 0.0)"),
            ]
        )
    }
}
