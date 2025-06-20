//
//  UserModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import Foundation

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
