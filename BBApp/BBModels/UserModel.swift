//
//  UserModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import Foundation

// MARK: — UserModel
/// Struct `UserModel` defines the user data structure.

// MARK: — IndustryType
/// Enumeration `IndustryType` with a `displayName` property for string representation.

// MARK: — UserModel + Sample
/// Adds sample data for previews/testing.

// TODO: Add `displayName` property like customerModel to cleanly handle missing last names
// TODO: add `Codable` conformance for when persistence is added.
struct UserModel: Identifiable {
    
    /// Unique identifier for the user
    var id: UUID = UUID()
    
    /// User's first name
    var firstName: String
    
    /// User's last name
    var lastName: String
    
    /// User's business name
    var businessName: String
    
    /// User's industry type for business
    var industryType: IndustryType
    
    /// Optional user profile image stored as `Data`
    var profileImageData: Data?
    
    /// Optional full name - Returns first and last if both exist
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
    
    
}
/// Defines supported industry types for the user's business
enum IndustryType: String, CaseIterable, Identifiable {
    case landscaping
    case pressureWashing
    case consulting
    case handyman
    case HVAC
    case productSales
    
    /// Raw value as ID for use in Picker or List
    var id: String {self.rawValue}
    
    /// User-friendly string for each industry type
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

extension UserModel {
    static let sample = UserModel(
        firstName: "Joshua",
        lastName: "Hauer",
        businessName: "Basic Business",
        industryType: .consulting,
        profileImageData: nil
    )
}
