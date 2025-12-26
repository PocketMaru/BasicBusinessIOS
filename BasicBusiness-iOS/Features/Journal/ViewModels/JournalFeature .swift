import Foundation

// Business statistics View Model outlining the data that exists within the business.
@MainActor
@Observable
final class JournalFeature {
    var userVM: UserVM
    var customerFeature: CustomerFeatureVM
    var quoteFeature: QuoteFeatureVM
    var invoiceFeature: InvoiceFeatureVM
    var expenseFeature: ExpenseFeatureVM
    var materialFeature: MaterialFeatureVM
    
    init (
        userVM: UserVM,
        customerFeature: CustomerFeatureVM,
        quoteFeature: QuoteFeatureVM,
        invoiceFeature: InvoiceFeatureVM,
        expenseFeature: ExpenseFeatureVM,
        materialFeature: MaterialFeatureVM
    ) {
        self.userVM = userVM
        self.customerFeature = customerFeature
        self.quoteFeature = quoteFeature
        self.invoiceFeature = invoiceFeature
        self.expenseFeature = expenseFeature
        self.materialFeature = materialFeature
    }
    
    // Total of all quotes.
    var quotedRevenue: Double {
        quoteFeature.allQuotes.reduce(0) { $0 + $1.totalCost}
    }
    
    // Total of all invoices.
    var invoicedRevenue: Double {
        invoiceFeature.allInvoices.reduce(0) {$0 + $1.totalCost}
    }
    
    // Total of all confirmed expenses.
    var expenseTotal: Double {
        expenseFeature.allExpenses.reduce(0) {$0 + $1.calcTotal}
    }
    
    // Total of all pending expenses in quotes.
    var forecastedExpenseTotal: Double {
        quoteFeature.allQuotes.reduce(0) { $0 + $1.pendingMaterialExpense.reduce(0) { $0 + $1.estimatedCost}}
    }
    
    // Total revenue including quote profit and loss.
    var forecastedProfit: Double {
        (invoicedRevenue + quotedRevenue) - (forecastedExpenseTotal + expenseTotal)
    }
    // Total revenue, including only confirmed profit and loss.
    var totalProfit: Double {
        invoicedRevenue - expenseTotal
    }
    
    var allCustomers: [CustomerModel] {
        customerFeature.allCustomers
    }
    
    var allQuotes: [QuoteModel] {
        quoteFeature.allQuotes
    }
    
    var allInvoices: [InvoiceModel] {
        invoiceFeature.allInvoices
    }
    
    var allExpenses: [ExpenseModel] {
        expenseFeature.allExpenses
    }
    
    var allMaterials: [MaterialModel] {
        materialFeature.allMaterials
    }
    
    var businessName: String {
        userVM.user.businessName
    }
}

