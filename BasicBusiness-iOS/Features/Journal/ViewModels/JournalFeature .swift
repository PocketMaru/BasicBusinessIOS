import Foundation

// Business statistics View Model outlining the data that exists within the business.
@MainActor
@Observable
final class JournalFeature {
    var router: JobDocumentRouterFeature
    var expenseFeature: ExpenseFeatureVM
    
    init (
        router: JobDocumentRouterFeature,
        expenseFeature: ExpenseFeatureVM,
    ) {
        self.router = router
        self.expenseFeature = expenseFeature
    }
    
    var quotedRevenue: Double {
        router.quoteFeatureVM.allQuotes.reduce(0) { $0 + router.totalCost(for: $1) }
    }
    
    var invoicedRevenue: Double {
        router.invoiceFeatureVM.allInvoices.reduce(0) { $0 + router.totalCost(for: $1) }
    }
    
    var expenseTotal: Double {
        expenseFeature.allExpenses.reduce(0) {$0 + $1.total}
    }
    
    var forecastedExpense: Double {
        router.quoteFeatureVM.allQuotes.reduce(0) { total, quote in
            total + quote.documentMaterialTotal { materialID in
                router.materialFeatureVM.materialSearchByID(with: materialID)?.unitCost ?? 0
            }
        }
    }
    
    var forecastedProfit: Double {
        (invoicedRevenue + quotedRevenue) - (forecastedExpense + expenseTotal)
    }

    var totalProfit: Double {
        invoicedRevenue - expenseTotal
    }
    
    var allCustomers: [CustomerModel] {
        router.customerFeatureVM.allCustomers
    }
    
    var allQuotes: [QuoteModel] {
        router.quoteFeatureVM.allQuotes
    }
    
    var allInvoices: [InvoiceModel] {
        router.invoiceFeatureVM.allInvoices
    }
    
    var allExpenses: [ExpenseModel] {
        expenseFeature.allExpenses
    }
    
    var allMaterials: [MaterialModel] {
        router.materialFeatureVM.allMaterials
    }
    
    var businessName: String {
        router.userVM.user.businessName
    }
    
    var totalCustomers: Int {
        router.customerFeatureVM.allCustomers.count
    }
    
    
}

