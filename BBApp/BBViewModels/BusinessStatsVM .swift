//
//  BBStatsViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

// Business statistics View Model outlining the data that exists within the business
class BusinessStatsVM {
    var quoteData: [QuoteModel]
    var expenseData: [ExpenseModel]
    
    init (quoteData: [QuoteModel], expenseData: [ExpenseModel]) {
        self.quoteData = quoteData
        self.expenseData = expenseData
    }
    
    var totalRevenue: Double {
        quoteData.reduce(0) { total, quote in
            total + Double(quote.totalCost ?? 0)}
    }
    
    var totalExpenses: Double {
        expenseData.reduce(0) { total, expense in
            total + Double(expense.amount)
        }
    }
    
    var profit: Double {
        totalRevenue - totalExpenses
    }
}

