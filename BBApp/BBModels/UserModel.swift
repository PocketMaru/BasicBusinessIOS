//
//  UserModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import Foundation
/// Enumeration `IndustryType` with a `displayName` property for string representation.
/// Struct `UserModel` defines the user data structure.
/// Extension to `UserModel` provides sample data for previews/testing.
enum IndustryType: String, CaseIterable, Identifiable {
    case landscaping
    case pressureWashing
    case consulting
    case handyman
    case HVAC
    case productSales
    
    var id: String {self.rawValue}
    
    var displayName: String {
        switch self {
        case .landscaping:
            return "Landscaping"
        case .pressureWashing:
            return "Pressure Washing"
        case .consulting:
            return "Consulting"
        case .handyman:
            return "Handyman"
        case .HVAC:
            return "HVAC"
        case .productSales:
            return "Product Sales"
        }
    }
}
struct UserModel: Identifiable {
    var id: UUID = UUID()
    var firstName: String
    var lastName: String
    var businessName: String
    var industryType: IndustryType
    var profileImageData: Data?
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
}

extension UserModel {
    static let sample = UserModel(
        firstName: "Joshua",
        lastName: "Hauer",
        businessName: "Basic Business",
        industryType: .consulting,
        profileImageData: nil
    )
}
