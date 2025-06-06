//
//  ExpenseVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

@Observable
final class ExpenseVM {
    var expenses: [ExpenseModel] = []
    var materialExpenses: [MaterialExpenseQM] = []
    init(expenses: [ExpenseModel]) {
        self.expenses = expenses
    }
    
    func addExpense(_ expense: ExpenseModel) {
        expenses.append(expense)
    }
    
    func convertMaterialToExpense(_ expense: MaterialExpenseQM) {
        if let matExpense = expense.toExpense() {
            return expenses.append(matExpense)
        }
    }
    
    func removeMaterialExpense(at index: Int){
        guard index >= 0 && index < materialExpenses.count else { return }
        materialExpenses.remove(at: index)
    }
    
    func removeExpense(at index: Int){
        guard index >= 0 && index < expenses.count else { return }
        expenses.remove(at: index)
    }
}
