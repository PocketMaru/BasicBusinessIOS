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
    
    var jobDocumentType: JobDocumentType = .invoice
    
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
        self.jobDocumentType = .invoice
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
        quote.jobDocumentType = .quote
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
        jobType: JobDocumentType = .invoice,
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
        mockModel.jobDocumentType = jobType
        mockModel.invoiceDate = invoiceDate
        mockModel.installationDate = installationDate
        mockModel.serviceDate = serviceDate
        
        return mockModel
    }
    
    static var mockList: [InvoiceModel] {
        [
            .mock(
                id: UUID(),
                customerID: UUID(),
                industryType: .none,
                serviceType: .custom("New Fence"),
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote for a fence.",
                subscriptionTotal: 0.0,
                laborCost: .flatRate(1000.0),
                additionalFees: 300.0,
                customFields: [.init(label: "Added Expense", value: 100.0)],
                materialExpenses: [.init(id: UUID(), name: "Material Expenses1", unitCost: 100.0, unitType: .unit)],
                jobType: .quote,
                invoiceDate: .now,
                installationDate: .now,
                serviceDate: .now,
            ),
            .mock(
                id: UUID(),
                customerID: UUID(),
                industryType: .none,
                serviceType: .none,
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote note.",
                subscriptionTotal: 100.0,
                laborCost: .flatRate(100.0),
                additionalFees: 100.0,
                customFields: [.init(label: "Added Expense", value: 100.0)],
                materialExpenses: [.init(id: UUID(), name: "Material Expenses1", unitCost: 100.0, unitType: .unit)],
                jobType: .quote,
                invoiceDate: .now,
                installationDate: .now,
                serviceDate: .now,
            ),
            .mock(
                id: UUID(),
                customerID: UUID(),
                industryType: .none,
                serviceType: .none,
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote note.",
                subscriptionTotal: 100.0,
                laborCost: .flatRate(100.0),
                additionalFees: 100.0,
                customFields: [.init(label: "Added Expense", value: 100.0)],
                materialExpenses: [.init(id: UUID(), name: "Material Expenses1", unitCost: 100.0, unitType: .unit)],
                jobType: .quote,
                invoiceDate: .now,
                installationDate: .now,
                serviceDate: .now,
            )
        ]
    }
}
