//
//  BBExpenseViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

@Observable
class BBExpenseVM {
    var expense: [BBExpenseModel] = []
    
    init(expense: [BBExpenseModel]) {
        self.expense = expense
    }
    
    func addExpense(
        name: String,
        amount: Double,
        date: Date
    ){
        let newExpense = BBExpenseModel(name: name, amount: amount, date: date)
        expense.append(newExpense)
    }
    
    func removeExpense(at index: Int){
        expense.remove(at: index)
    }
    
}
