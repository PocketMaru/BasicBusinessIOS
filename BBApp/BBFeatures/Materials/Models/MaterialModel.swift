import Foundation

struct MaterialModel: Identifiable, Codable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
    
}

extension MaterialModel {
    func toQuoteMaterial(addedAsExpense: Bool = false) -> MaterialExpenseModel {
        return MaterialExpenseModel(from: self, addedAsExpense: addedAsExpense)
    }
}

enum ProductUnitTypes: String, CaseIterable, Identifiable, Codable {
    var id: String { rawValue }
    
    case gram, ounce, pound, liter, gallon, bag, unit, piece
    
    var displayName: String {
        switch self {
        case .gram: return "grams"
        case .ounce: return "ounces"
        case .pound: return "pounds"
        case .liter: return "liters"
        case .gallon: return "gallons"
        case .bag: return "bags"
        case .unit: return "units"
        case .piece: return "pieces"
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
