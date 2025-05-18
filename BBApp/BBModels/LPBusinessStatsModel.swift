//
//  LPStatsModel.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import Foundation
import Observation

@Observable
// Business statistics model outlining the data that exists within the business
class BBBusinessStatsModel {
    // Variables that make up our stats model
    var totalRevenue: Double = 0.0
    var totalExpenses: Double = 0.0
    var totalCustomers: Int = 0
    
    var totalProfit: Double {
        return totalRevenue - totalExpenses
    }
    // Initializer
    init(totalRevenue: Double, totalExpenses: Double, totalCustomers: Int) {
        self.totalRevenue = totalRevenue
        self.totalExpenses = totalExpenses
        self.totalCustomers = totalCustomers
    }
    // Placeholder initializer
    init(){
        self.totalRevenue = 0.0
        self.totalExpenses = 0.0
        self.totalCustomers = 0
    }
    
}
