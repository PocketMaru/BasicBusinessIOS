//
//  BBQuoteViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

@Observable
class QuoteViewModel {
    var quote: [QuoteModel]
    
    init(quote: [QuoteModel]) {
        self.quote = quote
    }
    
    func calculateCost(for quote: QuoteModel) -> Double? {
        switch quote.quoteType {
        case .fixedRate:
            return quote.fixedRate ?? 0
        case .hourlyRate:
            guard let rate = quote.hourlyRate, let hours = quote.hoursWorked else {return nil}
            return rate * Double(hours)
        case .squareFootage:
            guard let rate = quote.squareFootRate, let sqft = quote.squareFootageAmount else {return nil}
            return rate * Double(sqft)
        }
    
    }
}
