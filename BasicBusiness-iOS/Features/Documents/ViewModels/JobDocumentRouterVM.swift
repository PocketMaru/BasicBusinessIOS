import Observation
import Foundation

@MainActor
@Observable
final class JobDocumentRouterVM {
    let customerListVM: CustomerListVM
    let quoteListVM: QuoteListVM
    let invoiceListVM: InvoiceListVM
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
    
    init(
        customerListVM: CustomerListVM,
        quoteListVM: QuoteListVM,
        invoiceListVM: InvoiceListVM,
        savedMaterials: [MaterialModel],
        saveQuoteUseCase: SaveQuoteUseCase,
        saveInvoiceUseCase: SaveInvoiceUseCase
    ) {
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
    
    enum JobDocumentRoute: Hashable {
        case quoteDetail(id: UUID)
        case invoiceDetail(id: UUID)
    }
    
    enum JobDocumentDetail {
        case quote(QuoteModel)
        case invoice(InvoiceModel)
    }
    
    func quote(withID id: UUID) -> QuoteModel? {
        quoteListVM.allQuotes.first { $0.id == id }
    }

    func invoice(withID id: UUID) -> InvoiceModel? {
        invoiceListVM.allInvoices.first { $0.id == id }
    }
    
    func form(for type: JobDocumentType) -> DocumentForm {
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
