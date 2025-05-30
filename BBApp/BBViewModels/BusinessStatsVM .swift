//
//  BusinessStatsVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

// Business statistics View Model outlining the data that exists within the business.
final class BusinessStatsVM {
    var quoteData: [QuoteModel]?
    var expenseData: [ExpenseModel]?
    var invoiceData: [InvoiceModel]?
    
    init (quoteData: [QuoteModel], expenseData: [ExpenseModel], invoiceData: [InvoiceModel]?) {
        self.quoteData = quoteData
        self.expenseData = expenseData
        self.invoiceData = invoiceData
    }
    // Total of all quotes.
    var quotedRevenue: Double {
        guard let quotes = quoteData else {return 0}
        return quotes.reduce(0) {$0 + ($1.totalCost ?? 0)}
    }
    // Total of all invoices.
    var invoicedRevenue: Double {
        guard let invoices = invoiceData else {return 0}
        return invoices.reduce(0) {$0 + ($1.totalCost ?? 0)}
    }
    // Total of all pending expenses in quotes.
    var quotedExpenses: Double {
        guard let quotes = quoteData else {return 0}
        return quotes.reduce(0) { $0 + $1.pendingExpenses.reduce(0) { $0 + $1.estimatedCost}}
    }
    // Total of all confirmed expenses.
    var confirmedExpenses: Double {
        guard let totalExpenses = expenseData else {return 0}
        return totalExpenses.reduce(0) {$0 + $1.total}
    }
    // Total revenue including quote profit and loss.
    var forecastedProfit: Double {
        return (invoicedRevenue + quotedRevenue) - (quotedExpenses + confirmedExpenses)
    }
    // Total revenue, including only confirmed profit and loss.
    var totalProfit: Double {
        return invoicedRevenue - confirmedExpenses
    }
}

