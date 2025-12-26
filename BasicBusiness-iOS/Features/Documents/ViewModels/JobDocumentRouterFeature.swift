import Observation
import Foundation

@MainActor
@Observable
final class JobDocumentRouterFeature {
    
    let userVM: UserVM
    let customerFeatureVM: CustomerFeatureVM
    let quoteFeatureVM: QuoteFeatureVM
    let invoiceFeatureVM: InvoiceFeatureVM
    let materialFeatureVM: MaterialFeatureVM
    var documentDateFilter: DocumentDateFilter = .today
    var activeForm: JobDocumentForm? = nil
    var route: JobDocumentRoute? = nil
    
    var quoteRows: [JobDocumentRowData] {
        quoteFeatureVM.allQuotes.map { jobDocumentRowItems(for:.quote($0)
        )}
    }
    
    var invoiceRows: [JobDocumentRowData] {
        invoiceFeatureVM.allInvoices.map { jobDocumentRowItems(for: .invoice($0)
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

    enum JobDocumentForm: Identifiable, Hashable {
        case quote(id: UUID, vm: QuoteFormVM)
        case invoice(id: UUID, vm: InvoiceFormVM)
        
        var id: UUID {
            switch self {
            case .quote(let id, _),
                .invoice(let id, _):
                return id
            }
        }
        
        static func == (lhs: JobDocumentForm, rhs: JobDocumentForm) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    enum JobDocumentRoute: Hashable {
        case quoteDetail(id: UUID)
        case invoiceDetail(id: UUID)
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
        customerFeatureVM: CustomerFeatureVM,
        quoteFeatureVM: QuoteFeatureVM,
        invoiceFeatureVM: InvoiceFeatureVM,
        materialFeatureVM: MaterialFeatureVM
    ) {
        self.userVM = userVM
        self.customerFeatureVM = customerFeatureVM
        self.quoteFeatureVM = quoteFeatureVM
        self.invoiceFeatureVM = invoiceFeatureVM
        self.materialFeatureVM = materialFeatureVM
    }
    
    func quote(withID id: UUID) -> QuoteModel? {
        quoteFeatureVM.allQuotes.first { $0.id == id }
    }

    func invoice(withID id: UUID) -> InvoiceModel? {
        invoiceFeatureVM.allInvoices.first { $0.id == id }
    }
    
    func startCreating(_ intent: JobDocumentCreationIntent) {
        activeForm = form(for: intent)
    }
    
    func form(for type: JobDocumentCreationIntent) -> JobDocumentForm {
        switch type {
        case .quote:
            let vm = makeQuoteFormVM()
            return .quote(id: vm.draft.id, vm: vm)
        case .invoice:
            let vm = makeInvoiceFormVM()
            return .invoice(id: vm.draft.id, vm: vm)
        }
    }
    
    func startEditingQuote(id: UUID) {
        guard let quote = quote(withID: id) else { return }
        
        activeForm = .quote(
            id: quote.id,
            vm: QuoteFormVM(
                quote: quote,
                mode: .edit,
                availableCustomers: customerFeatureVM.allCustomers,
                savedMaterials: materialFeatureVM.allMaterials,
                onSubmit: { [weak self] draft in
                    try self?.quoteFeatureVM.updateQuote(from: draft)
                })
        )
    }
    
    func startEditingInvoice(id: UUID) {
        guard let invoice = invoice(withID: id) else { return }
        
        activeForm = .invoice(
            id: invoice.id,
            vm: InvoiceFormVM(
                invoice: invoice,
                mode: .edit,
                availableCustomers: customerFeatureVM.allCustomers,
                savedMaterials: materialFeatureVM.allMaterials,
                onSubmit: { [weak self] draft in
                    try self?.invoiceFeatureVM.updateInvoice(from: draft)
                })
        )
    }
    private func makeQuoteFormVM() -> QuoteFormVM {
        let form = QuoteFormVM(
            quote: QuoteModel(),
            mode: FormMode.add,
            availableCustomers: customerFeatureVM.allCustomers,
            savedMaterials: materialFeatureVM.allMaterials,
            onSubmit: { [weak self] draft in
                try self?.quoteFeatureVM.addQuote(from: draft)
            }
        )
        form.loadIndustryFields(for: userVM.user.industryType)
        return form
    }
    
    private func makeInvoiceFormVM() -> InvoiceFormVM {
        let form = InvoiceFormVM(
            invoice: InvoiceModel(),
            mode: FormMode.add,
            availableCustomers: customerFeatureVM.allCustomers,
            savedMaterials: materialFeatureVM.allMaterials,
            onSubmit: { [weak self] draft in
                try self?.invoiceFeatureVM.addInvoice(from: draft)
            }
        )
        form.loadIndustryFields(for: userVM.user.industryType)
        return form
    }
    
    func customer(for customerID: UUID) -> CustomerModel? {
        customerFeatureVM.allCustomers.first { $0.id == customerID }
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
        
        let customerName = customerFeatureVM.allCustomers.first(where: { $0.id == customerID })?.displayName ?? "Unknown Customer"
        
        return JobDocumentRowData(
            id: id,
            customerName: customerName,
            totalCost: total,
            date: date,
            documentType: type
        )
    }
}
