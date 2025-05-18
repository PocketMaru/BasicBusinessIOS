//
//  BBExpenseModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

class ExpenseModel {
    var name: String
    var amount: Double
    var date: Date
    
    init(name: String, amount: Double, date: Date) {
        self.name = name
        self.amount = amount
        self.date = date
    }
}
