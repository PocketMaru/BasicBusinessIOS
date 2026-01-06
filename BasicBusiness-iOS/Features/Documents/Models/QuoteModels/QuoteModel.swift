import Foundation

struct QuoteModel: JobDocumentProtocol, Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var customerID: UUID
    
    var industryType: IndustryType
    
    var serviceType: ServiceType
    var selectedCustomService: String
    
    var pricingMethods: [PricingMethodModel]

    var notes: String?
    var subscriptionTotal: Double?
    
    var laborCost: LaborType?
    
    var customFields: [CustomFieldModel] = []

    var jobDocumentType: JobDocumentType = .quote
    
    var documentDate: Date = Date()
    var documentDueDate: Date = Date()
    var documentInstallationDate: Date?
    var documentServiceDate: Date?
    var customDateRange: Set<DateComponents> = []
    
    // Pending expenses, these are expenses tied to quotes, this allows the user to see what expenses will be when a job converts to invoice, allowing forecasting of future expenses from jobs.
    var documentMaterials: [DocumentMaterialModel] = []
    
    /// This initializer is needed to create a quote, the initializer provides default values for properties provided from the outside.
    init() {
        self.id = UUID()
        self.customerID = UUID()
        self.industryType = .none
        self.serviceType = .recurring
        self.selectedCustomService = ""
        self.pricingMethods = []
        self.notes = nil
        self.subscriptionTotal = nil
        self.laborCost = nil
        self.customFields = []
        self.jobDocumentType = .quote
        self.documentDate = Date()
        self.documentDueDate = Date()
        self.documentInstallationDate = nil
        self.documentServiceDate = nil
        self.customDateRange = []
        self.documentMaterials = []
    }
}

extension QuoteModel {
    func toInvoice() -> InvoiceModel {
        var invoice = InvoiceModel()
        invoice.id = self.id
        invoice.customerID = self.customerID
        invoice.industryType = self.industryType
        invoice.serviceType = self.serviceType
        invoice.selectedCustomService = self.selectedCustomService
        invoice.pricingMethods = self.pricingMethods
        invoice.notes = self.notes
        invoice.subscriptionTotal = self.subscriptionTotal
        invoice.laborCost = self.laborCost
        invoice.customFields = self.customFields
        invoice.jobDocumentType = .invoice
        invoice.documentDate = self.documentDate
        invoice.documentDueDate = self.documentDueDate
        invoice.documentInstallationDate = self.documentInstallationDate
        invoice.documentServiceDate = self.documentServiceDate
        invoice.customDateRange = self.customDateRange
        invoice.documentMaterials = self.documentMaterials
        return invoice
    }
}

extension QuoteModel {
    static func mock(
        id: UUID = UUID(),
        customerID: UUID = UUID(),
        industryType: IndustryType = .none,
        serviceType: ServiceType = .none,
        selectedCustomService: String = "",
        pricingMethods: [PricingMethodModel] = [],
        notes: String = "This is the note for the quote.",
        subscriptionTotal: Double = 0.0,
        laborCost: LaborType = .none,
        customFields: [CustomFieldModel] = [],
        materialExpenses: [DocumentMaterialModel] = [],
        jobType: JobDocumentType = .quote,
        documentDate: Date = Date(),
        documentDueDate: Date = Date(),
        documentInstallationDate: Date? = nil,
        documentServiceDate: Date? = nil,
        customDateRange: Set<DateComponents> = [],
        documentMaterials: [DocumentMaterialModel] = []
        
    ) -> QuoteModel {
        var mockModel = QuoteModel()
        
        mockModel.id = id
        mockModel.customerID = customerID
        mockModel.industryType = industryType
        mockModel.serviceType = serviceType
        mockModel.selectedCustomService = selectedCustomService
        mockModel.pricingMethods = pricingMethods
        mockModel.notes = notes
        mockModel.subscriptionTotal = subscriptionTotal
        mockModel.laborCost = laborCost
        mockModel.customFields = customFields
        mockModel.jobDocumentType = jobType
        mockModel.documentDate = documentDate
        mockModel.documentDueDate = documentDueDate
        mockModel.documentInstallationDate = documentInstallationDate
        mockModel.documentServiceDate = documentServiceDate
        mockModel.customDateRange = customDateRange
        mockModel.documentMaterials = documentMaterials
        return mockModel
    }
    
    static var mockList: [QuoteModel] {
        [
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[1].id,
                industryType: .none,
                serviceType: .none,
                selectedCustomService: "",
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote note.",
                subscriptionTotal: 100.0,
                laborCost: .flatRate(100.0),
                customFields: [.init(label: "Added Expense", value: 100.0)],
                jobType: .quote,
                documentDate: .today,
                documentDueDate: .today,
                documentInstallationDate: .today,
                documentServiceDate: .today,
                customDateRange: [],
                documentMaterials: [],
            ),
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[2].id,
                industryType: .none,
                serviceType: .none,
                selectedCustomService: "",
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote note.",
                subscriptionTotal: 100.0,
                laborCost: .flatRate(100.0),
                customFields: [.init(label: "Added Expense", value: 100.0)],
                documentDate: .today,
                documentDueDate: .today,
                documentInstallationDate: .today,
                documentServiceDate: .today,
                customDateRange: [],
                documentMaterials: [],
            ),
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[3].id,
                industryType: .none,
                serviceType: .none,
                selectedCustomService: "",
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote note.",
                subscriptionTotal: 100.0,
                laborCost: .flatRate(100.0),
                customFields: [.init(label: "Added Expense", value: 100.0)],
                jobType: .quote,
                documentDate: .today,
                documentDueDate: .today,
                documentInstallationDate: .today,
                documentServiceDate: .today,
                customDateRange: [],
                documentMaterials: [],
            )
        ]
    }
}


