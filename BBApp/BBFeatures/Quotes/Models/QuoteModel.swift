import Foundation

struct CustomField: Codable, Hashable {
    let label: String
    let value: String
}

struct QuoteModel: JobDocumentProtocol, Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var customerID: UUID
    
    var industryType: IndustryType
    var serviceType: ServiceType
    var pricingMethods: [PricingMethod]

    var notes: String?
    var subscriptionTotal: Double?
    
    var laborCost: LaborType?
    var additionalFees: Double?
    
    var customFields: [CustomField] = []
    var materialExpenses: [MaterialExpenseModel] = []

    var jobType: JobType = .quote
    
    var quoteDate: Date = Date()
    var installationDate: Date?
    var serviceDate: Date?
    
    // Pending expenses, these are expenses tied to quotes, this allows the user to see what expenses will be when a job converts to invoice, allowing forecasting of future expenses from jobs.
    var pendingMaterialExpense: [MaterialExpensePreview] = []
    
    /// This initializer is needed to create a quote, the initializer provides default values for properties provided from the outside.
    init() {
        self.id = UUID()
        self.customerID = UUID()
        self.industryType = .none
        self.serviceType = .none
        self.pricingMethods = []
        self.notes = nil
        self.subscriptionTotal = nil
        self.laborCost = nil
        self.additionalFees = nil
        self.customFields = []
        self.materialExpenses = []
        self.jobType = .quote
        self.pendingMaterialExpense = []
        self.quoteDate = Date()
        self.installationDate = nil
        self.serviceDate = nil
    }
}

extension QuoteModel {
    func toInvoice() -> InvoiceModel {
        var invoice = InvoiceModel()
        invoice.id = self.id
        invoice.customerID = self.customerID
        invoice.industryType = self.industryType
        invoice.serviceType = self.serviceType
        invoice.pricingMethods = self.pricingMethods
        invoice.notes = self.notes
        invoice.subscriptionTotal = self.subscriptionTotal
        invoice.laborCost = self.laborCost
        invoice.additionalFees = self.additionalFees
        invoice.customFields = self.customFields
        invoice.materialExpenses = self.materialExpenses
        invoice.jobType = .invoice
        invoice.invoiceDate = self.quoteDate
        invoice.installationDate = self.installationDate
        invoice.serviceDate = self.serviceDate
        return invoice
    }
}



