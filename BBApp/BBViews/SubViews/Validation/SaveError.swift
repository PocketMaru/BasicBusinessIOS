//
//  InputValidation.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/20/25.
//

import Foundation

/// Enum offering input for different save errors.
/// Kept as an enum for future case additions.
enum SaveError: Error {
    case writeFailed(reason: String)
    var message: String {
        switch self {
        case .writeFailed(let reason): 
            return "Failed to save: \(reason)"
        }
    }
}
