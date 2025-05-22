//
//  BBExpenseModel.swift
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
}
struct ExpenseModel {
    var id: UUID
    var name: String
    var type: ExpenseType
    var date: Date
    var description: String?
    var hoursWorked: Double?
    var hourlyRate: Double?
    var fixedRate: Double?
    var materialExpense: MaterialExpenseQM?
    
    var total: Double {
        let material = materialExpense?.totalCost ?? 0
        switch type {
        case .food, .gas, .housing, .utilities, .healthcare, .clothing,   .transportation, .entertainment, .other:
            return (fixedRate ?? 0) + (material)
        case .employeeWages:
            return (hoursWorked ?? 0) * (hourlyRate ?? 0) + (material)
        case .materialExpense:
            return material
        }
    }
}
