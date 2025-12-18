import Observation
import Foundation

@MainActor
@Observable
final class JobDocumentRouterVM {
    
    let userVM: UserVM
    let customerListVM: CustomerListVM
    let quoteListVM: QuoteListVM
    let invoiceListVM: InvoiceListVM
    var documentDateFilter: DocumentDateFilter = .today
    var activeForm: JobDocumentForm? = nil
    var route: JobDocumentRoute? = nil
    private let savedMaterials: [MaterialModel]
    private let saveQuoteUseCase: SaveQuoteUseCase
    private let saveInvoiceUseCase: SaveInvoiceUseCase
    
    var quoteRows: [JobDocumentRowData] {
        quoteListVM.allQuotes.map { jobDocumentRowItems(for:.quote($0)
        )}
    }
    
    var invoiceRows: [JobDocumentRowData] {
        invoiceListVM.allInvoices.map { jobDocumentRowItems(for: .invoice($0)
        )}
    }
    
    var quoteRowsFilteredByDate: [JobDocumentRowData] {
        quoteRows.filter { row in
            documentDateFilter.matches(row.date)
        }
    }
    
    var invoiceRowsFilteredByDate: [JobDocumentRowData] {
        invoiceRows.filter { row in
            documentDateFilter.matches(row.date)
        }
    }

    enum JobDocumentForm {
        case quote(QuoteFormVM)
        case invoice(InvoiceFormVM)
    }
    
    enum JobDocumentRoute: Hashable {
        case quoteDetail(id: UUID)
        case invoiceDetail(id: UUID)
        case createQuote
        case createInvoice
        case editQuote(id: UUID)
        case editInvoice(id: UUID)
    }
    
    enum JobDocumentDetail {
        case quote(QuoteModel)
        case invoice(InvoiceModel)
    }
    
    enum JobDocumentCreationIntent {
        case quote
        case invoice
    }
    init(
        userVM: UserVM,
        customerListVM: CustomerListVM,
        quoteListVM: QuoteListVM,
        invoiceListVM: InvoiceListVM,
        savedMaterials: [MaterialModel],
        saveQuoteUseCase: SaveQuoteUseCase,
        saveInvoiceUseCase: SaveInvoiceUseCase,
    ) {
        self.userVM = userVM
        self.customerListVM = customerListVM
        self.quoteListVM = quoteListVM
        self.invoiceListVM = invoiceListVM
        self.savedMaterials = savedMaterials
        self.saveQuoteUseCase = saveQuoteUseCase
        self.saveInvoiceUseCase = saveInvoiceUseCase
    }
    
    func quote(withID id: UUID) -> QuoteModel? {
        quoteListVM.allQuotes.first { $0.id == id }
    }

    func invoice(withID id: UUID) -> InvoiceModel? {
        invoiceListVM.allInvoices.first { $0.id == id }
    }
    
    func startCreating(_ intent: JobDocumentCreationIntent) {
        activeForm = form(for: intent)
    }
    
    func form(for type: JobDocumentCreationIntent) -> JobDocumentForm {
        switch type {
        case .quote:
            return .quote(makeQuoteFormVM())
        case .invoice:
            return .invoice(makeInvoiceFormVM())
        }
    }
    
    private func makeQuoteFormVM() -> QuoteFormVM {
        let form = QuoteFormVM(
            quote: QuoteModel(),
            mode: FormMode.add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: savedMaterials,
            onSubmit: { [weak self] draft in
                try self?.quoteListVM.addQuote(from: draft)
            }
        )
        form.loadIndustryFields(for: userVM.user.industryType)
        return form
    }
    
    private func makeInvoiceFormVM() -> InvoiceFormVM {
        let form = InvoiceFormVM(
            invoice: InvoiceModel(),
            mode: FormMode.add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: savedMaterials,
            onSubmit: { [weak self] draft in
                try self?.invoiceListVM.addInvoice(from: draft)
            }
        )
        form.loadIndustryFields(for: userVM.user.industryType)
        return form
    }
    
    func customer(for customerID: UUID) -> CustomerModel? {
        customerListVM.allCustomers.first { $0.id == customerID }
    }
    
    func jobDocumentRowItems(for document: JobDocumentRowItem) -> JobDocumentRowData {
        
        let id: UUID
        let customerID: UUID
        let total: Double
        let date: Date
        let type: JobDocumentType
        
        switch document {
        case .quote(let quote):
            id = quote.id
            customerID = quote.customerID
            total = quote.totalCost
            date = quote.quoteDate
            type = .quote
        case .invoice(let invoice):
            id = invoice.id
            customerID = invoice.customerID
            total = invoice.totalCost
            date = invoice.invoiceDate
            type = .invoice
        }
        
        let customerName = customerListVM.allCustomers.first(where: { $0.id == customerID })?.displayName ?? "Unknown Customer"
        
        return JobDocumentRowData(
            id: id,
            customerName: customerName,
            totalCost: total,
            date: date,
            documentType: type
        )
    }
}
