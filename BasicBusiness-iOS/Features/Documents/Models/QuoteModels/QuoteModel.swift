import Foundation

struct CustomField: Codable, Hashable {
    let label: String
    let value: Double
}

struct QuoteModel: JobDocumentProtocol, Identifiable, Codable, Equatable, Hashable {
    
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

    var jobDocumentType: JobDocumentType = .quote
    
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
        self.jobDocumentType = .quote
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
        invoice.jobDocumentType = .invoice
        invoice.invoiceDate = self.quoteDate
        invoice.installationDate = self.installationDate
        invoice.serviceDate = self.serviceDate
        return invoice
    }
}

extension QuoteModel {
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
        jobType: JobDocumentType = .quote,
        quoteDate: Date = Date(),
        installationDate: Date? = nil,
        serviceDate: Date? = nil,
        pendingMaterialExpense: [MaterialExpensePreview] = []
        
    ) -> QuoteModel {
        var mockModel = QuoteModel()
        
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
        mockModel.quoteDate = quoteDate
        mockModel.installationDate = installationDate
        mockModel.serviceDate = serviceDate
        mockModel.pendingMaterialExpense = pendingMaterialExpense
        
        return mockModel
    }
    
    static var mockList: [QuoteModel] {
        [
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[1].id,
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
                quoteDate: .today,
                installationDate: .today,
                serviceDate: .today,
                pendingMaterialExpense: [
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material1", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material2", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material3", unitCost: 100.0, unitType: .unit)),
                ],
            ),
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[2].id,
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
                quoteDate: .daysAgo(10),
                installationDate: .daysAgo(10),
                serviceDate: .daysAgo(10),
                pendingMaterialExpense: [
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material4", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material5", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material6", unitCost: 100.0, unitType: .unit)),
                ],
            ),
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[3].id,
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
                quoteDate: .daysAgo(3),
                installationDate: .daysAgo(3),
                serviceDate: .daysAgo(3),
                pendingMaterialExpense: [
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material7", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material8", unitCost: 100.0, unitType: .unit)),
                    MaterialExpensePreview(from: MaterialExpenseModel(id: UUID(), name: "Material9", unitCost: 100.0, unitType: .unit)),
                ],
            )
        ]
    }
}


