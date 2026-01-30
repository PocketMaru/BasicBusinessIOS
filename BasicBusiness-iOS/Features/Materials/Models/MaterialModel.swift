import Foundation

struct MaterialDraftModel: Identifiable, Equatable {
    var id: UUID?
    var name: String = ""
    var description: String = ""
    var unitCost: String = ""
    var unitType: ProductUnitTypes = .unit
}

extension MaterialDraftModel {
    func toMaterial() throws -> MaterialModel {
        return MaterialModel(
            id: id ?? UUID(),
            name: name,
            description: description,
            unitCost: unitCost,
            unitType: unitType
        )
    }
}

struct MaterialModel: Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID
    var name: String
    var description: String
    var unitCost: String
    var unitType: ProductUnitTypes
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        unitCost: String,
        unitType: ProductUnitTypes
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.unitCost = unitCost
        self.unitType = unitType
    }
}

extension MaterialModel {
    func toFormState() -> MaterialDraftModel {
        MaterialDraftModel(
            id: id,
            name: name,
            description: description,
            unitCost: unitCost,
            unitType: unitType
        )
    }
}

enum ProductUnitTypes: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
    case gram, ounce, pound, liter, gallon, bag, unit, piece
    
    var displayName: String {
        switch self {
        case .gram: return "Gram"
        case .ounce: return "Ounce"
        case .pound: return "Pound"
        case .liter: return "Liter"
        case .gallon: return "Gallon"
        case .bag: return "Bag"
        case .unit: return "Unit"
        case .piece: return "Piece"
        }
    }
    
    var category: UnitCategory {
        switch self {
        case .gram, .ounce, .pound:
            return .weight
        case .liter, .gallon:
            return .volume
        case .bag, .unit, .piece:
            return .quantity
        }
    }
}

enum UnitCategory {
    case volume
    case weight
    case quantity
}
