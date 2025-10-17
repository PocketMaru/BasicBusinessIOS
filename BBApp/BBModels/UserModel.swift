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
    var businessName: String = "Business Name"
    
    /// User's industry type for business
    var industryType: IndustryType
    
    /// Optional user profile image stored as `Data`
    var profileImageData: Data?
    
    /// Optional full name - Returns first and last if both exist
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
//MARK: Struct for easy picker implementation 
struct IndustryChoice: Identifiable, Hashable {
    let id: String
    let displayName: String
    let type: IndustryType
    
    static let all: [IndustryChoice] = [
        IndustryChoice(id: "landscaping", displayName: "Landscaping", type: .landscaping(.empty)),
        IndustryChoice(id: "pressureWashing", displayName: "Pressure Washing", type: .pressureWashing(.empty)),
        IndustryChoice(id: "consulting", displayName: "Consulting", type: .consulting(.empty)),
        IndustryChoice(id: "handyman", displayName: "Handyman", type: .handyman(.empty)),
        IndustryChoice(id: "HVAC", displayName: "HVAC", type: .HVAC(.empty)),
        IndustryChoice(id: "productSales", displayName: "Product Sales", type: .productSales(.empty)),
        IndustryChoice(id: "none", displayName: "None", type: .none)
    ]
    
    static func == (lhs: IndustryChoice, rhs: IndustryChoice) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
extension IndustryType {
    var isNone: Bool {
        if case .none = self { return true }
        return false
    }
}
extension UserModel {
    static let sample = UserModel(
        firstName: "Joshua",
        lastName: "Hauer",
        businessName: "Basic Business",
        industryType: .landscaping(.empty),
        profileImageData: nil
    )
}
