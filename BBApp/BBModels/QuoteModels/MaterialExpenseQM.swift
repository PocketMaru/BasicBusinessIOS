//
//  QuoteMaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/22/25.
//

import Foundation

// Creating Material Expenses.
// This allows a user to convert materials needed for a quote to expenses.
struct MaterialExpenseQM {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var unitType: ProductUnitTypes
    var addedAsExpense: Bool = false
    var expenseStatus: ExpenseStatus = .pending
}

// Extension to MaterialExpensesQM allowing conversion of materials to expenses and adding the date.
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
}

// Inventory item snapshot to monitor what materials were used.
// Adding a variable to subtract usage from stock.
extension MaterialExpenseQM {
    init(from material: MaterialModel, addedAsExpense: Bool = false) {
        self.id = material.id
        self.name = material.name
        self.description = material.description
        self.unitCost = material.unitCost
        self.unitType = material.unitType
        self.addedAsExpense = addedAsExpense
    }
}

// Represents added materials as expenses prior to finalization through invoicing.
struct MaterialExpensePreview: Identifiable {
    var id = UUID()
    var label: String
    var estimatedCost: Double
    var expenseStatus: ExpenseStatus = .pending
}
