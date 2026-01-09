import Foundation

protocol JobDocumentTotalProtocol {
    var pricingMethods: [PricingMethodModel] { get }
    var customFields: [CustomFieldModel] { get }
    var laborCost: LaborType? { get }
    var subscriptionTotal: Double? { get }
    var documentMaterials: [DocumentMaterialModel] { get }
}

extension JobDocumentTotalProtocol {
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
