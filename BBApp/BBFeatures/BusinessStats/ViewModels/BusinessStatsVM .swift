import Foundation

// Business statistics View Model outlining the data that exists within the business.
@MainActor
@Observable
final class BusinessStatsVM {
    var quoteData: QuoteListVM
    var expenseData: ExpenseListVM
    var invoiceData: InvoiceListVM
    
    init (quoteData: QuoteListVM, expenseData: ExpenseListVM, invoiceData: InvoiceListVM) {
        self.quoteData = quoteData
        self.expenseData = expenseData
        self.invoiceData = invoiceData
    }
    // Total of all quotes.
    var quotedRevenue: Double {
        quoteData.allQuotes.reduce(0) { $0 + $1.totalCost}
    }
    // Total of all invoices.
    var invoicedRevenue: Double {
        return invoiceData.allInvoices.reduce(0) {$0 + $1.totalCost}
    }
    // Total of all pending expenses in quotes.
    var forecastedExpenses: Double {
        quoteData.allQuotes.reduce(0) { $0 + $1.pendingMaterialExpense.reduce(0) { $0 + $1.estimatedCost}}
    }
    // Total of all confirmed expenses.
    var confirmedExpenses: Double {
        return expenseData.allExpenses.reduce(0) {$0 + $1.calcTotal}
    }
    // Total revenue including quote profit and loss.
    var forecastedProfit: Double {
        return (invoicedRevenue + quotedRevenue) - (forecastedExpenses + confirmedExpenses)
    }
    // Total revenue, including only confirmed profit and loss.
    var totalProfit: Double {
        return invoicedRevenue - confirmedExpenses
    }
}

