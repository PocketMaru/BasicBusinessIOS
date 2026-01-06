import Observation
import Foundation
import SwiftUI

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
    var adapter: JobDocFormAdapter? {
        guard let form = activeForm else { return nil }
        return adapter(for: form)
    }
    
    var isFormPresented: Binding<Bool> {
        Binding(
            get: { self.activeForm != nil },
            set: { isPresented in
                if !isPresented {
                    self.activeForm = nil
                }
            }
        )
    }
    
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
            case .quote(let id, _), .invoice(let id, _):
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
        materialFeatureVM: MaterialFeatureVM,
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
                onSubmit: { [weak self] draft in
                    try self?.invoiceFeatureVM.updateInvoice(from: draft)
                })
        )
    }
    private func makeQuoteFormVM() -> QuoteFormVM {
        let form = QuoteFormVM(
            quote: QuoteModel(),
            mode: FormMode.add,
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
            total = self.totalCost(for: quote)
            date = quote.documentDate
            type = .quote
        case .invoice(let invoice):
            id = invoice.id
            customerID = invoice.customerID
            total = self.totalCost(for: invoice)
            date = invoice.documentDate
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
// MARK: - Bindings routed from adapter
@MainActor
extension JobDocumentRouterFeature {
    func adapter(for form: JobDocumentForm) -> JobDocFormAdapter {
        switch form {
        case .quote(_, let vm):
            return JobDocFormAdapter(
                serviceType: Binding(
                    get: { vm.draft.serviceType },
                    set: { vm.draft.serviceType = $0 }
                ),
                customService: Binding(
                    get: { vm.draft.selectedCustomService },
                    set: { vm.draft.selectedCustomService = $0 }
                ),
                pricingMethods: Binding(
                    get: { vm.draft.pricingMethods },
                    set: { vm.draft.pricingMethods = $0}
                ),
                customFields: Binding(
                    get: { vm.draft.customFields },
                    set: { vm.draft.customFields = $0}
                ),
                notes: Binding(
                    get: { vm.draft.notes ?? ""},
                    set: { vm.draft.notes = $0}
                ),
                creationDate: Binding(
                    get: { vm.draft.documentDate },
                    set: { vm.draft.documentDate = $0 }
                ),
                dueDate: Binding(
                    get: { vm.draft.documentDueDate },
                    set: { vm.draft.documentDueDate = $0 }
                ),
                installationDate: Binding(
                    get: { vm.draft.documentInstallationDate ?? Date() },
                    set: { vm.draft.documentInstallationDate = $0 }
                ),
                serviceDate: Binding(
                    get: { vm.draft.documentServiceDate ?? Date() },
                    set: { vm.draft.documentServiceDate = $0 }
                ),
                customDate: Binding(
                    get: { vm.draft.customDateRange },
                    set: { vm.draft.customDateRange = $0 }
                ),
                netTerms: { days in
                    vm.draft.documentDueDate = Date.netDate(days, from: vm.draft.documentDate)
                },
                formTitle: "Create Quote",
                total: totalCost(for: vm.draft)
            )
        case .invoice(_, let vm):
            return JobDocFormAdapter(
                serviceType: Binding(
                    get: { vm.draft.serviceType },
                    set: { vm.draft.serviceType = $0 }
                ),
                customService: Binding(
                    get: { vm.draft.selectedCustomService },
                    set: { vm.draft.selectedCustomService = $0 }
                ),
                pricingMethods: Binding(
                    get: { vm.draft.pricingMethods },
                    set: { vm.draft.pricingMethods = $0}
                ),
                customFields: Binding(
                    get: { vm.draft.customFields },
                    set: { vm.draft.customFields = $0}
                ),
                notes: Binding(
                    get: { vm.draft.notes ?? "" },
                    set: { vm.draft.notes = $0}
                ),
                creationDate: Binding(
                    get: { vm.draft.documentDate },
                    set: { vm.draft.documentDate = $0 }
                ),
                dueDate: Binding(
                    get: { vm.draft.documentDueDate },
                    set: { vm.draft.documentDueDate = $0 }
                ),
                installationDate: Binding(
                    get: { vm.draft.documentInstallationDate ?? Date() },
                    set: { vm.draft.documentInstallationDate = $0 }
                ),
                serviceDate: Binding(
                    get: { vm.draft.documentServiceDate ?? Date() },
                    set: { vm.draft.documentServiceDate = $0 }
                ),
                customDate: Binding(
                    get: { vm.draft.customDateRange },
                    set: { vm.draft.customDateRange = $0 }
                ),
                netTerms: { days in
                    vm.draft.documentDueDate = Date.netDate(days, from: vm.draft.documentDate)
                },
                formTitle: "Create Invoice",
                total: totalCost(for: vm.draft)
            )
        }
    }
}

@MainActor
extension JobDocumentRouterFeature {
    func convertDocMaterialToExpense(
        from docMaterial: DocumentMaterialModel,
        with docType: JobDocumentForm
    ) throws -> ExpenseModel {
        
        guard let material = materialFeatureVM.materialSearchByID(with: docMaterial.materialID) else {
            throw ConversionError.writeFailed(reason: "Could not find material with ID: \(docMaterial.materialID)")
            #warning("Will trigger an alert")
        }
    
        let total = docMaterial.totalCost(with: material.unitCost)
        
        switch docType {
        case .quote(let quoteID, let quoteVM):
            return ExpenseModel(
                name: material.name,
                type: .materialExpense,
                date: quoteVM.draft.documentDate,
                description: material.description,
                documentMaterialID: docMaterial.id,
                linkedQuoteID: quoteID,
                linkedInvoiceID: nil,
                itemTotal: total,
                laborTotal: nil
            )
        case .invoice(let invoiceID, let invoiceVM):
            return ExpenseModel(
                name: material.name,
                type: .materialExpense,
                date: invoiceVM.draft.documentDate,
                description: material.description,
                documentMaterialID: docMaterial.id,
                linkedQuoteID: nil,
                linkedInvoiceID: invoiceID,
                itemTotal: total,
                laborTotal: nil
            )
        }
    }
}

@MainActor
extension JobDocumentRouterFeature {
    
    func totalCost(for document: JobDocumentProtocol) -> Double {
        
        let materialTotal = document.documentMaterialTotal { materialID in
            materialFeatureVM.materialSearchByID(with: materialID)?.unitCost ?? 0
        }
        let laborCost = document.laborCost?.calculateTotal() ?? 0
        let customFieldCost = document.customFields.map { Double($0.value ?? 0) }.reduce(0, +)
        let subscriptionTotalCost = document.subscriptionTotal ?? 0
        let pricingMethodTotal = document.pricingMethods.reduce(0) { $0 + $1.calculateTotal() }
        return materialTotal
        + laborCost
        + customFieldCost
        + subscriptionTotalCost
        + pricingMethodTotal
    }
}
