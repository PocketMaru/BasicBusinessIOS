import Observation

@MainActor
@Observable
final class JobDocumentRouterVM {
    private let customerListVM: CustomerListVM
    private let quoteListVM: QuoteListVM
    private let invoiceListVM: InvoiceListVM
    private let savedMaterials: [MaterialModel]
    private let saveQuoteUseCase: SaveQuoteUseCase
    private let saveInvoiceUseCase: SaveInvoiceUseCase
    
    init(customerListVM: CustomerListVM, quoteListVM: QuoteListVM, invoiceListVM: InvoiceListVM, savedMaterials: [MaterialModel], saveQuoteUseCase: SaveQuoteUseCase, saveInvoiceUseCase: SaveInvoiceUseCase) {
        // TODO: Create `SaveInvoiceUseCase` and invoiceVM and formVM
        self.customerListVM = customerListVM
        self.quoteListVM = quoteListVM
        self.invoiceListVM = invoiceListVM
        self.savedMaterials = savedMaterials
        self.saveQuoteUseCase = saveQuoteUseCase
        self.saveInvoiceUseCase = saveInvoiceUseCase
    }
    
    enum DocumentForm {
        case quote(QuoteFormVM)
        case invoice(InvoiceFormVM)
    }
    
    func form(for type: JobType) -> DocumentForm {
        switch type {
        case .quote:
            return .quote(makeQuoteFormVM())
        case .invoice:
            return .invoice(makeInvoiceFormVM())
        }
    }
    
    private func makeQuoteFormVM() -> QuoteFormVM {
        QuoteFormVM(
            quote: QuoteModel(),
            mode: FormMode.add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: savedMaterials,
            onSubmit: { [weak self] draft in
                try self?.quoteListVM.addQuote(from: draft)
            }
        )
    }
    
    private func makeInvoiceFormVM() -> InvoiceFormVM {
        InvoiceFormVM(
            invoice: InvoiceModel(),
            mode: FormMode.add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: savedMaterials,
            onSubmit: { [weak self] draft in
                try self?.invoiceListVM.addInvoice(from: draft)
            }
        )
    }
}
