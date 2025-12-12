import Foundation

struct MaterialExpenseModel: Identifiable, Codable, Equatable, Hashable {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
    var addedAsExpense: Bool = false
}

extension MaterialExpenseModel {
    func toExpense(date: Date = Date()) -> ExpenseModel? {
        guard addedAsExpense else {return nil}
        return ExpenseModel(
            id: UUID(),
            name: name,
            type: .materialExpense,
            date: date,
            description: description,
            materialExpense: self,
            itemTotal: 100
            
        )
    }
    
    init(from material: MaterialModel, addedAsExpense: Bool = false) {
        self.id = material.id
        self.name = material.name
        self.description = material.description
        self.unitCost = material.unitCost
        self.unitType = material.unitType
        self.addedAsExpense = addedAsExpense
    }
}

struct MaterialExpensePreview: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var label: String
    var estimatedCost: Double
}

extension MaterialExpensePreview {
    init (from expense: MaterialExpenseModel) {
        self.id = expense.id
        self.label = expense.name
        self.estimatedCost = expense.unitCost
    }
}

extension MaterialExpenseModel {
    static let sample = MaterialExpenseModel(
        id: UUID(),
        name: "Sample Material",
        description: "This is a sample material",
        unitCost: 10.00,
        unitType: .pound
    )
    
    static let sampleList: [MaterialExpenseModel] = [
        .sample,
        MaterialExpenseModel(
            id: UUID(),
            name: "Another Sample Material",
            description: "This is another sample material",
            unitCost: 20.00,
            unitType: .pound
        ),
        MaterialExpenseModel(
            id: UUID(),
            name: "Yet Another Sample Material",
            description: "This is yet another sample material",
            unitCost: 30.00,
            unitType: .pound
        )
    ]
    
    static func randomMaterialExpense() -> MaterialExpenseModel {
        sampleList.randomElement()!
    }
    
    static func sample(_ index: Int) -> MaterialExpenseModel {
        sampleList[index % sampleList.count]
    }
}
