//
//  QuoteMaterialModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/22/25.
//

import Foundation

// This allows the user to allow a material addition to be calculated in expenses during quotes.

struct MaterialExpenseQM {
    var id: UUID
    var name: String
    var description: String?
    var unitCost: Double
    var quantityUsed: Int
    var unitType: MaterialUnitTypes
    var totalCost: Double {
        return Double(quantityUsed) * unitCost
    }
}

// Used to pass in material expenses to the expenseViewModel
extension MaterialExpenseQM {
    func toExpense(date: Date = Date()) -> ExpenseModel {
        ExpenseModel(
            id: UUID(),
            name: name,
            type: .materialExpense,
            date: date,
            description: description,
            hoursWorked: nil,
            hourlyRate: nil,
            fixedRate: nil,
            materialExpense: self
            
        )
    }
}// Inventory item snapshot to monitor what was used.
// Adding a variable to subtract usage from stock.
extension MaterialExpenseQM {
    init(from material: MaterialModel, quantityUsed: Int) {
        self.id = material.id
        self.name = material.name
        self.description = material.description
        self.unitCost = material.unitCost
        self.quantityUsed = quantityUsed
        self.unitType = material.unitType
    }
}
