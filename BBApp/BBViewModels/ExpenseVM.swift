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
    init(expenses: [ExpenseModel]) {
        self.expenses = expenses
    }
    
    func addExpense(_ expense: ExpenseModel) {
        expenses.append(expense)
    }
    
    func addMaterialExpense(_ expense: MaterialExpenseQM) {
        if let matExpense = expense.toExpense() {
            return expenses.append(matExpense)
        }
    }
    
    func removeExpense(at index: Int){
        guard index >= 0 && index < expenses.count else { return }
        expenses.remove(at: index)
    }
}
