import Foundation

enum DocumentRef: Codable,Equatable, Hashable {
    case invoice(UUID)
    case quote(UUID)
}

struct DocumentMaterialModel: Identifiable, Codable, Hashable {
    var id: UUID
    var materialID: UUID
    var document: DocumentRef
    
    var isExpense: Bool
    var quantity: Double
    var unitCostOverride: Double?
    
    init(
        id: UUID = UUID(),
        materialID: UUID,
        document: DocumentRef,
        isExpense: Bool,
        quantity: Double,
        unitCostOverride: Double? = nil
    ) {
        self.id = id
        self.materialID = materialID
        self.document = document
        self.isExpense = isExpense
        self.quantity = quantity
        self.unitCostOverride = unitCostOverride
    }
    
    func totalCost(with base: Double?) -> Double {
        (unitCostOverride ?? (base ?? 0)) * quantity
    }
}
