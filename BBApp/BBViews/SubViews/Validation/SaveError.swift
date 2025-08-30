//
//  InputValidation.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/20/25.
//

import Foundation

/// Enum defining different errors for customer model inputs
enum SaveCustomerError: Error {
    case writeFailed(reason: String)
    var message: String {
        switch self {
        case .writeFailed(let reason): 
            return "Failed to save customer: \(reason)"
        }
    }
}

