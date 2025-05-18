//
//  BBExpenseViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

@Observable
class ExpenseVM {
    var expense: [ExpenseModel] = []
    
    init(expense: [ExpenseModel]) {
        self.expense = expense
    }
    
    func addExpense(
        name: String,
        amount: Double,
        date: Date
    ){
        let newExpense = ExpenseModel(name: name, amount: amount, date: date)
        expense.append(newExpense)
    }
    
    func removeExpense(at index: Int){
        expense.remove(at: index)
    }
    
}
