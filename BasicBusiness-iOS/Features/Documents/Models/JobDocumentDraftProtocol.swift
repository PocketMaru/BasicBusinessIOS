import Foundation

protocol JobDocumentDraftProtocol: Codable {
    var id: UUID { get set }
    var customerID: UUID? { get set }
    
    var industryType: IndustryType { get set }
    
    var serviceType: ServiceType { get set }
    var selectedCustomService: String { get set }
    
    var pricingMethods: [PricingMethodModel] { get set }
    
    var notes: String? { get set }
    var subscriptionTotal: Double? { get set }

    var laborCost: LaborType? { get set }
    
    var customFields: [CustomFieldModel] { get set }

    var jobDocumentType: JobDocumentType { get set }
    
    var documentDate: Date { get set }
    var documentDueDate: Date { get set }
    var documentInstallationDate: Date? { get set}
    var documentServiceDate: Date? { get set }
    var customDateRange: Set<DateComponents> { get set }
    
    var documentMaterials: [DocumentMaterialModel] { get set }
}

extension JobDocumentDraftProtocol {
    func documentMaterialTotal(
    materialCost: (UUID) -> Double
    ) -> Double {
        documentMaterials.reduce(0) { total, docMaterial in
            total + docMaterial.totalCost(
                with: materialCost(docMaterial.materialID)
            )
        }
    }
}
