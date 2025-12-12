import Foundation

struct InvoiceModel: JobDocumentProtocol, Identifiable, Codable, Equatable, Hashable {

    var id: UUID = UUID()
    var customerID: UUID
    
    var industryType: IndustryType
    var serviceType: ServiceType
    var pricingMethods: [PricingMethodModel]
    
    var notes: String?
    var subscriptionTotal: Double?
    
    var laborCost: LaborType?
    var additionalFees: Double?
    
    var customFields: [CustomField] = []
    var materialExpenses: [MaterialExpenseModel] = []
    
    var jobType: JobType = .invoice
    
    var invoiceDate: Date = Date()
    var installationDate: Date?
    var serviceDate: Date?
    
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
        self.jobType = .invoice
        self.invoiceDate = Date()
        self.installationDate = nil
        self.serviceDate = nil
    }
}

extension InvoiceModel {
    func toQuote() -> QuoteModel {
        var quote = QuoteModel()
        quote.id = self.id
        quote.customerID = self.customerID
        quote.industryType = self.industryType
        quote.serviceType = self.serviceType
        quote.pricingMethods = self.pricingMethods
        quote.notes = self.notes
        quote.subscriptionTotal = self.subscriptionTotal
        quote.laborCost = self.laborCost
        quote.additionalFees = self.additionalFees
        quote.customFields = self.customFields
        quote.materialExpenses = self.materialExpenses
        quote.jobType = .quote
        quote.quoteDate = self.invoiceDate
        quote.installationDate = self.installationDate
        quote.serviceDate = self.serviceDate
        return quote
    }
}

extension InvoiceModel {
    static func mock(
        id: UUID = UUID(),
        customerID: UUID = UUID(),
        industryType: IndustryType = .none,
        serviceType: ServiceType = .none,
        pricingMethods: [PricingMethodModel] = [],
        notes: String = "This is the note for the quote.",
        subscriptionTotal: Double = 0.0,
        laborCost: LaborType = .none,
        additionalFees: Double = 0.0,
        customFields: [CustomField] = [],
        materialExpenses: [MaterialExpenseModel] = [],
        jobType: JobType = .invoice,
        invoiceDate: Date = Date(),
        installationDate: Date? = nil,
        serviceDate: Date? = nil,
    ) -> InvoiceModel {
        var mockModel = InvoiceModel()
        
        mockModel.id = id
        mockModel.customerID = customerID
        mockModel.industryType = industryType
        mockModel.serviceType = serviceType
        mockModel.pricingMethods = pricingMethods
        mockModel.notes = notes
        mockModel.subscriptionTotal = subscriptionTotal
        mockModel.laborCost = laborCost
        mockModel.additionalFees = additionalFees
        mockModel.customFields = customFields
        mockModel.materialExpenses = materialExpenses
        mockModel.jobType = jobType
        mockModel.invoiceDate = invoiceDate
        mockModel.installationDate = installationDate
        mockModel.serviceDate = serviceDate
        
        return mockModel
    }
}
