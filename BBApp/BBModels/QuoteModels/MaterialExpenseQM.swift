//
//  QuoteMaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/22/25.
//

import Foundation

// MARK: — MaterialExpenseQM
/// Struct `MaterialExpenseQM` defines expenses related to materials that are created when building quotes

// MARK: — MaterialExpensePreview
/// Struct `MaterialExpensePreview` represents added materials as expenses prior to finalization through invoicing.

// MARK: — MaterialExpenseQM + toExpense
/// Adds the conversion of materials added to a quote to expenses.

// MARK: — MaterialExpenseQM + addedAsExpense
/// Adds an initializer to `MaterialExpenseQM` that creates a new instance from an existing `MaterialModel`.
/// Includes the `addedAsExpense` parameter to specify whether the material should be logged as an expense.

struct MaterialExpenseQM: Identifiable {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
    var addedAsExpense: Bool = false
    var expenseStatus: ExpenseStatus = .pending
}

extension MaterialExpenseQM {
    func toExpense(date: Date = Date()) -> ExpenseModel? {
        guard addedAsExpense else {return nil}
        return ExpenseModel(
            id: UUID(),
            name: name,
            type: .materialExpense,
            date: date,
            description: description,
            hoursWorked: nil,
            hourlyRate: nil,
            fixedRate: nil,
            expenseStatus: .confirmed,
            materialExpense: self
            
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

struct MaterialExpensePreview: Identifiable {
    var id = UUID()
    var label: String
    var estimatedCost: Double
    var expenseStatus: ExpenseStatus = .pending
}

extension MaterialExpensePreview {
    init (from expense: MaterialExpenseQM) {
        self.id = expense.id
        self.label = expense.name
        self.estimatedCost = expense.unitCost
        self.expenseStatus = expense.expenseStatus
    }
}

extension MaterialExpenseQM {
    static let sample = MaterialExpenseQM(
        id: UUID(),
        name: "Sample Material",
        description: "This is a sample material",
        unitCost: 10.00,
        unitType: .pound
    )
    
    static let sampleList: [MaterialExpenseQM] = [
        .sample,
        MaterialExpenseQM(
            id: UUID(),
            name: "Another Sample Material",
            description: "This is another sample material",
            unitCost: 20.00,
            unitType: .pound
        ),
        MaterialExpenseQM(
            id: UUID(),
            name: "Yet Another Sample Material",
            description: "This is yet another sample material",
            unitCost: 30.00,
            unitType: .pound
        )
    ]
    
    static func randomMaterialExpense() -> MaterialExpenseQM {
        sampleList.randomElement()!
    }
    
    static func sample(_ index: Int) -> MaterialExpenseQM {
        sampleList[index % sampleList.count]
    }
}
