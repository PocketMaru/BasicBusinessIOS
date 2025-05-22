//
//  BBStatsViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

// Business statistics View Model outlining the data that exists within the business
final class BusinessStatsVM {
    var quoteData: [QuoteModel]?
    var expenseData: [ExpenseModel]?
    
    init (quoteData: [QuoteModel], expenseData: [ExpenseModel]) {
        self.quoteData = quoteData
        self.expenseData = expenseData
    }
    
    var totalRevenue: Double {
        guard let quotes = quoteData else {return 0}
        return quotes.reduce(0) {$0 + ($1.totalCost ?? 0)}
    }
    
    var totalExpenses: Double {
        guard let totalExpenses = expenseData else {return 0}
        return totalExpenses.reduce(0) {$0 + $1.total}
    }
    
    var profit: Double {
        totalRevenue - totalExpenses
    }
}

