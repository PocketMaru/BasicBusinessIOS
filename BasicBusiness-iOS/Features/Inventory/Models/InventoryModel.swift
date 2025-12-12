import Foundation

/// Future implementation of inventory, currently not connected to the application.
struct InventoryModel: Identifiable, Codable, Equatable, Hashable {
    var id: UUID = UUID()
    var name: String
    var cost: Double
    var productQuantityType: ProductUnitTypes
    var productQuantity: Double
    var description: String?
}



