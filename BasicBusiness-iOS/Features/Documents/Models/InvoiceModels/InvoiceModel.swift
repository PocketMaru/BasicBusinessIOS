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

extension InvoiceModel {
    func toQuote() -> QuoteModel {
        QuoteModel(
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
            jobDocumentType: .quote,
            documentDate: self.documentDate,
            documentDueDate: self.documentDueDate,
            documentInstallationDate: self.documentInstallationDate,
            documentServiceDate: self.documentServiceDate,
            customDateRange: self.customDateRange,
            documentMaterials: self.documentMaterials
        )
    }
    
    func toDraft() -> InvoiceDraftModel {
        InvoiceDraftModel(from: self)
    }
}

extension InvoiceModel: JobDocumentTotalProtocol {}
