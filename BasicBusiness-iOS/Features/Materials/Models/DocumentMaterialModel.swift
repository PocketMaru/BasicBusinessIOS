import Foundation

struct DocumentMaterialModel: Identifiable, Codable, Hashable {
    var id: UUID
    var materialID: UUID
    var documentID: UUID
    
    var isExpense: Bool
    var quantity: Double
    var unitCostOverride: Double?
    
    init(
        id: UUID = UUID(),
        materialID: UUID,
        documentID: UUID,
        isExpense: Bool,
        quantity: Double,
        unitCostOverride: Double? = nil
    ) {
        self.id = id
        self.materialID = materialID
        self.documentID = documentID
        self.isExpense = isExpense
        self.quantity = quantity
        self.unitCostOverride = unitCostOverride
    }
    
    func totalCost(with base: Double?) -> Double {
        (unitCostOverride ?? (base ?? 0)) * quantity
    }
}
