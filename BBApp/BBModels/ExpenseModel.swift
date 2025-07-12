//
//  ExpenseModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation
/// Struct `ExpenseModel` defines the expense data structure.
/// Enumeration `ExpenseType` with a `name` property for string representation.
/// Enumeration `ExpenseStatus` with a `name` property for string representation.
/// Extension to `ExpenseModel` provides sample data for previews/testing.

struct ExpenseModel: Identifiable {
    
    /// Unique identifier for each expense
    var id: UUID = UUID()
    
    /// Expense name
    var name: String
    
    /// Expense type (e.g., gas or food)
    var type: ExpenseType
    
    /// Expense date
    var date: Date
    
    /// Optional expense description
    var description: String?
    
    /// Optional employee wage expense
    var hoursWorked: Double?
    
    /// Optional employee hourly rate expense
    var hourlyRate: Double?
    
    /// Optional employee fixed rate expense
    var fixedRate: Double?
    
    /// Expense Status for pending and confirmed expenses
    var expenseStatus: ExpenseStatus
    
    /// Optional for expenses related to materials used
    var materialExpense: MaterialExpenseQM?
    
    /// Computed property for expense total - Calculated from expense type
    ///  - If `.employeeWages`: total = hours x rage + material cost
    ///  - If `.materialExpense`: total = material cost only
    ///  - Else: total = fixed rate + material cost
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

/// Enumeration defining the expense types included within the app
enum ExpenseType {
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

/// Enum for pending and confirmed expenses
enum ExpenseStatus {
    case pending
    case confirmed
    
    var name: String {
        switch self {
        case .pending:
            return "Pending"
        case .confirmed:
            return "Confirmed"
        }
    }
}

/// Extension for expense sample data
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
