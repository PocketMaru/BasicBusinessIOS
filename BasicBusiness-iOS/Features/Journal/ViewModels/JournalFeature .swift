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
    
    var quotedRevenue: Double {
        quoteFeature.allQuotes.reduce(0) { $0 + $1.totalCost}
    }
    
    var invoicedRevenue: Double {
        invoiceFeature.allInvoices.reduce(0) {$0 + $1.totalCost}
    }
    
    var expenseTotal: Double {
        expenseFeature.allExpenses.reduce(0) {$0 + $1.calcTotal}
    }
    
    var forecastedExpense: Double {
        quoteFeature.allQuotes.reduce(0) { $0 + $1.pendingMaterialExpense.reduce(0) { $0 + $1.estimatedCost}}
    }
    
    var forecastedProfit: Double {
        (invoicedRevenue + quotedRevenue) - (forecastedExpense + expenseTotal)
    }

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
    
    var totalCustomers: Int {
        customerFeature.allCustomers.count
    }
    
    
}

