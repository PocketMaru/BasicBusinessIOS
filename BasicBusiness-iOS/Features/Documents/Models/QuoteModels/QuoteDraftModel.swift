import Foundation

struct QuoteDraftModel: JobDocumentDraftProtocol, Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var customerID: UUID?
    
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
    init(from document: QuoteModel) {
        self.id = document.id
        self.customerID = document.customerID
        self.industryType = document.industryType
        self.serviceType = document.serviceType
        self.selectedCustomService = document.selectedCustomService
        self.pricingMethods = document.pricingMethods
        self.notes = document.notes
        self.subscriptionTotal = document.subscriptionTotal
        self.laborCost = document.laborCost
        self.customFields = document.customFields
        self.jobDocumentType = document.jobDocumentType
        self.documentDate = document.documentDate
        self.documentDueDate = document.documentDueDate
        self.documentInstallationDate = document.documentInstallationDate
        self.documentServiceDate = document.documentServiceDate
        self.customDateRange = document.customDateRange
        self.documentMaterials = document.documentMaterials
    }
}

extension QuoteDraftModel {
    init(
        documentType: JobDocumentType,
        industryType: IndustryType
    ) {
        self.id = UUID()
        self.customerID = nil
        self.industryType = industryType
        self.serviceType = .maintenance
        self.selectedCustomService = ""
        self.pricingMethods = []
        self.notes = nil
        self.subscriptionTotal = nil
        self.laborCost = nil
        self.customFields = [CustomFieldModel(label:"", value: nil)]
        self.jobDocumentType = documentType
        self.documentDate = Date()
        self.documentDueDate = Date()
        self.documentInstallationDate = nil
        self.documentServiceDate = nil
        self.customDateRange = []
        self.documentMaterials = []
    }
}

extension QuoteDraftModel: JobDocumentTotalProtocol {}
