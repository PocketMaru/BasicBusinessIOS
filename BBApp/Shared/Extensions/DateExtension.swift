//
//  DateExtension.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/28/25.
//

import Foundation

extension Date {
    var formattedMonthDayYear: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
