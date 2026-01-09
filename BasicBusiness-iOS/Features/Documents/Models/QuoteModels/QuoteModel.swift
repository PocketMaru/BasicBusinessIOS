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
    init(
        id: UUID,
        customerID: UUID,
        industryType: IndustryType,
        serviceType: ServiceType,
        selectedCustomService: String,
        pricingMethods: [PricingMethodModel],
        notes: String?,
        subscriptionTotal: Double?,
        laborCost: LaborType?,
        customFields: [CustomFieldModel],
        jobDocumentType: JobDocumentType,
        documentDate: Date,
        documentDueDate: Date,
        documentInstallationDate: Date?,
        documentServiceDate: Date?,
        customDateRange: Set<DateComponents>,
        documentMaterials: [DocumentMaterialModel]
    ) {
        self.id = id
        self.customerID = customerID
        self.industryType = industryType
        self.serviceType = serviceType
        self.selectedCustomService = selectedCustomService
        self.pricingMethods = pricingMethods
        self.notes = notes
        self.subscriptionTotal = subscriptionTotal
        self.laborCost = laborCost
        self.customFields = customFields
        self.jobDocumentType = jobDocumentType
        self.documentDate = documentDate
        self.documentDueDate = documentDueDate
        self.documentInstallationDate = documentInstallationDate
        self.documentServiceDate = documentServiceDate
        self.customDateRange = customDateRange
        self.documentMaterials = documentMaterials
    }
}

extension QuoteModel {
    func toInvoice() -> InvoiceModel {
        InvoiceModel(
            id: self.id,
            customerID: self.customerID,
            industryType: self.industryType,
            serviceType: self.serviceType,
            selectedCustomService: self.selectedCustomService,
            pricingMethods: self.pricingMethods,
            notes: self.notes,
            subscriptionTotal: self.subscriptionTotal,
            laborCost: self.laborCost,
            customFields: self.customFields,
            jobDocumentType: .invoice,
            documentDate: self.documentDate,
            documentDueDate: self.documentDueDate,
            documentInstallationDate: self.documentInstallationDate,
            documentServiceDate: self.documentServiceDate,
            customDateRange: self.customDateRange,
            documentMaterials: self.documentMaterials
        )
    }
    
    func toDraft() -> QuoteDraftModel {
        QuoteDraftModel(from: self)
    }
}

extension QuoteModel: JobDocumentTotalProtocol {}
