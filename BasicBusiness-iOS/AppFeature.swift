import Foundation

@MainActor
@Observable
final class AppFeature {
    let userVM: UserVM
    
    let customerFeatureVM: CustomerFeatureVM
    let customerListVM: CustomerListVM
    
    let materialFeatureVM: MaterialFeatureVM
    let materialListVM: MaterialListVM
    
    let quoteFeatureVM: QuoteFeatureVM
    let quoteListVM: QuoteListVM
    
    let invoiceFeatureVM: InvoiceFeatureVM
    let invoiceListVM: InvoiceListVM
    
    let expenseFeatureVM: ExpenseFeatureVM
    let expenseListVM: ExpenseListVM
    
    
    
    let journalFeature: JournalFeature
    
    let jobDocRouterFeature: JobDocumentRouterFeature
    
    init() {
        self.userVM = UserVM(
            user: UserModel.sample
        )
        self.customerFeatureVM = CustomerFeatureVM()
        self.customerListVM = CustomerListVM(
            customerFeatureVM: customerFeatureVM
        )
        
        self.materialFeatureVM = MaterialFeatureVM()
        self.materialListVM = MaterialListVM()
        
        self.quoteFeatureVM = QuoteFeatureVM()
        self.quoteListVM = QuoteListVM(
            quoteFeatureVM: quoteFeatureVM,
            customerFeatureVM: customerFeatureVM,
            materialListVM: materialListVM
        )
        
        self.invoiceFeatureVM = InvoiceFeatureVM()
        self.invoiceListVM = InvoiceListVM(
            invoiceFeatureVM: invoiceFeatureVM,
            customerFeatureVM: customerFeatureVM,
            materialFeatureVM: materialFeatureVM
        )
        
        self.expenseFeatureVM = ExpenseFeatureVM()
        self.expenseListVM = ExpenseListVM()
        
        journalFeature = JournalFeature(
            userVM: userVM,
            customerFeature: customerFeatureVM,
            quoteFeature: quoteFeatureVM,
            invoiceFeature: invoiceFeatureVM,
            expenseFeature: expenseFeatureVM,
            materialFeature: materialFeatureVM
        )
        
        jobDocRouterFeature = JobDocumentRouterFeature(
            userVM: userVM,
            customerFeatureVM: customerFeatureVM,
            quoteFeatureVM: quoteFeatureVM,
            invoiceFeatureVM: invoiceFeatureVM,
            materialFeatureVM: materialFeatureVM
        )
    }
}
