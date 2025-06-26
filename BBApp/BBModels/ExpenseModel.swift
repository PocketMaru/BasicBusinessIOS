//
//  ExpenseModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

enum ExpenseType {
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

enum ExpenseStatus {
    case pending
    case confirmed
}

extension ExpenseStatus: CustomStringConvertible {
    var description: String {
        switch self {
        case .pending:
            return "Pending"
        case .confirmed:
            return "Confirmed"
        }
    }
}

struct ExpenseModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var type: ExpenseType
    var date: Date
    var description: String?
    var hoursWorked: Double?
    var hourlyRate: Double?
    var fixedRate: Double?
    var expenseStatus: ExpenseStatus
    var materialExpense: MaterialExpenseQM?
    
    var total: Double {
        let material = materialExpense?.unitCost ?? 0
        switch type {
        case .food, .gas, .housing, .utilities, .healthcare, .clothing, .transportation, .entertainment, .other:
            return (fixedRate ?? 0) + (material)
        case .employeeWages:
            return (hoursWorked ?? 0) * (hourlyRate ?? 0) + (material)
        case .materialExpense:
            return material
        }
    }
}
// Extension for sample data.
extension ExpenseModel {
    static let sample = ExpenseModel(
        id: UUID(),
        name: "Sample Expense",
        type: .food,
        date: Date(),
        description: nil,
        hoursWorked: nil,
        hourlyRate: nil,
        fixedRate: 100.0,
        expenseStatus: .confirmed
    )
    
    static let sampleList: [ExpenseModel] = [
        .sample,
        ExpenseModel(
            id: UUID(),
            name: "Another Sample Expense",
            type: .employeeWages,
            date: Date(),
            description: nil,
            hoursWorked: 10.0,
            hourlyRate: 25.0,
            fixedRate: nil,
            expenseStatus: .confirmed),
        
        ExpenseModel(
            id: UUID(),
            name: "Yet Another Sample Expense",
            type: .clothing,
            date: Date(),
            description: nil,
            hoursWorked: nil,
            hourlyRate: nil,
            fixedRate: 300,
            expenseStatus: .confirmed),
        
        ExpenseModel(
            id: UUID(),
            name: "Last Sample Expense",
            type: .employeeWages,
            date: Date(),
            description: nil,
            hoursWorked: 5.0,
            hourlyRate: 15.0,
            fixedRate: 400,
            expenseStatus: .confirmed)
    ]
}
