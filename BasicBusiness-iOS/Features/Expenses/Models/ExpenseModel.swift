import Foundation

struct ExpenseModel: Identifiable, Codable, Equatable, Hashable {

    var id: UUID = UUID()
    var name: String
    var type: ExpenseType
    var date: Date
    var description: String?
    var laborCharge: LaborType?
    var materialExpense: MaterialExpenseModel?
    var linkedQuoteID: UUID?
    var linkedInvoiceID: UUID?
    var itemTotal: Double
    var calcTotal: Double {
        let material = materialExpense?.unitCost ?? 0
        let laborCharge = self.laborCharge?.calculateTotal() ?? 0
        let finalCost = laborCharge + material + itemTotal
        return finalCost
    }
}

/// Enumeration defining the expense types included within the app
enum ExpenseType: Codable, Equatable, Hashable {
    // TODO: Add `icon` and `color` variables to support UI visuals.
    // Used for SwiftUI labels, chip-style tags, and category-based styling.
    case food
    case gas
    case housing
    case utilities
    case healthcare
    case clothing
    case transportation
    case entertainment
    case employeeWages
    case materialExpense
    case other
    
    /// User-friendly string for each expense type
    var name: String {
        switch self {
        case .food:
            return "Food"
        case .gas:
            return "Gas"
        case .housing:
            return "Housing"
        case .utilities:
            return "Utilities"
        case .healthcare:
            return "Healthcare"
        case .clothing:
            return "Clothing"
        case .transportation:
            return "Transportation"
        case .entertainment:
            return "Entertainment"
        case .employeeWages:
            return "Employee Wages"
        case .materialExpense:
            return "Material Expense"
        case .other:
            return "Other"
        }
    }
}
