import Foundation

struct InvoiceModel: JobDocumentProtocol, Identifiable, Codable, Equatable, Hashable {

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
    
    var jobDocumentType: JobDocumentType = .invoice
    
    var documentDate: Date = Date()
    var documentDueDate: Date = Date()
    var documentInstallationDate: Date?
    var documentServiceDate: Date?
    var customDateRange: Set<DateComponents> = []
    
    var documentMaterials: [DocumentMaterialModel] = []
    
    init() {
        self.id = UUID()
        self.customerID = UUID()
        self.industryType = .none
        self.serviceType = .none
        self.selectedCustomService = ""
        self.pricingMethods = []
        self.notes = nil
        self.subscriptionTotal = nil
        self.laborCost = nil
        self.customFields = []
        self.jobDocumentType = .invoice
        self.documentDate = Date()
        self.documentDueDate = Date()
        self.documentInstallationDate = nil
        self.documentServiceDate = nil
        self.customDateRange = []
        self.documentMaterials = []
    }
}

extension InvoiceModel {
    func toQuote() -> QuoteModel {
        var quote = QuoteModel()
        quote.id = self.id
        quote.customerID = self.customerID
        quote.industryType = self.industryType
        quote.serviceType = self.serviceType
        quote.selectedCustomService = self.selectedCustomService
        quote.pricingMethods = self.pricingMethods
        quote.notes = self.notes
        quote.subscriptionTotal = self.subscriptionTotal
        quote.laborCost = self.laborCost
        quote.customFields = self.customFields
        quote.jobDocumentType = .quote
        quote.documentDate = self.documentDate
        quote.documentDueDate = self.documentDueDate
        quote.documentInstallationDate = self.documentInstallationDate
        quote.documentServiceDate = self.documentServiceDate
        quote.customDateRange = self.customDateRange
        quote.documentMaterials = self.documentMaterials
        return quote
    }
}

extension InvoiceModel {
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
        jobType: JobDocumentType = .invoice,
        documentDate: Date = Date(),
        documentDueDate: Date = Date(),
        documentInstallationDate: Date? = nil,
        documentServiceDate: Date? = nil,
        customDateRange: Set<DateComponents> = [],
        documentMaterials: [DocumentMaterialModel] = []
    ) -> InvoiceModel {
        var mockModel = InvoiceModel()
        
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
    
    static var mockList: [InvoiceModel] {
        [
            .mock(
                id: UUID(),
                customerID: CustomerModel.mockList[1].id,
                industryType: .none,
                serviceType: .none,
                selectedCustomService: "",
                pricingMethods: [.init(type: .fixedRate)],
                notes: "This is a quote for a fence.",
                subscriptionTotal: 0.0,
                laborCost: .flatRate(1000.0),
                customFields: [.init(label: "Added Expense", value: 100.0)],
                jobType: .quote,
                documentDate: .today,
                documentDueDate: .today,
                documentInstallationDate: .today,
                documentServiceDate: .today,
                customDateRange: [],
                documentMaterials: []
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
                jobType: .quote,
                documentDate: .today,
                documentDueDate: .today,
                documentInstallationDate: .today,
                documentServiceDate: .today,
                customDateRange: [],
                documentMaterials: []
            ),
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
                documentMaterials: []
            ),
        ]
    }
}
