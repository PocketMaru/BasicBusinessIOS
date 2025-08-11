//
//  CustomerModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/6/25.
//

import Foundation
/// Struct `CustomerModel` defines the customer data structure across the app.
/// Includes identity, contact info, and optional billing fields.
/// Extension to `CustomerModel` provides sample data for previews/testing.

// MARK: - Pending Refactors
// TODO: Replace all 'fullName` uses with `displayName` app-wide.
// TODO: Consider making lastName optional if user editing stays flexible.
// TODO: Audit views using fullName to clean up fallback logic.
// When editing, `lastName` may be empty, so fullName looks awkward.
struct CustomerModel: Identifiable, Hashable, Codable, Equatable {
    /// Unique identifier for customer id
    var id: UUID = UUID()
    
    /// Customer first name
    var firstName: String = ""
    
    /// Customer last name
    var lastName: String = ""
    
    /// Customer email address
    var email: String = ""
    
    /// Optional customer address, not every customer needs an address
    var address: String? = nil
    
    /// Optional customer zip code
    var zipCode: String? = nil
    
    /// Customer phone number
    var phone: String = ""
    
    /// Optional info on customer pay status
    var paidBill: Bool? = false
    
    /// Optional full name of customer when first and last exist.
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
    
    /// Returns `firstName` if `lastName` is empty (after trimming whitespace); otherwise, returns "firstName lastName".
    var displayName: String {
        lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        firstName :
        "\(firstName) \(lastName)"
    }
    
    var loyaltyDate: Date = Date()
}

extension CustomerModel {
    static let sample = CustomerModel(
        firstName: "John",
        lastName: "Doe",
        email: "johndoe@example.com",
        phone: "(123) 456-7890",
        paidBill: true
    )
    
    static let sampleList: [CustomerModel] = [
        .sample,
        CustomerModel(
            firstName: "Joshua",
            lastName: "Hauer",
            email: "joshuahauer@icloud.com",
            address: "43 Ginger Circle",
            zipCode: "34748", phone: "352-272-2099",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Kaley",
            lastName: "Hauer",
            email: "Kaleyhauer@icloud.com",
            address: "43 Ginger Circle",
            zipCode: "34748", phone: "408-808-2843",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Raven",
            lastName: "Hauer",
            email: "ravenhauer@icloud.com",
            address: "43 Ginger Circle",
            zipCode: "34748", phone: "444-555-6666",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Valkyrie",
            lastName: "Hauer",
            email: "valkyriehauer@icloud.com",
            address: "43 Ginger Circle",
            zipCode: "34748", phone: "333-222-1111",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Goose",
            lastName: "BABA",
            email: "goosebaba@icloud.com",
            address: "43 Ginger Circle",
            zipCode: "34748", phone: "111-222-3333",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Leo",
            lastName: "Castro",
            email: "leocastro@icloud.com",
            address: "201 Palm Cove Drive",
            zipCode: "33101", phone: "305-123-4567",
            paidBill: true
        ),
        CustomerModel(
            firstName: "Sienna",
            lastName: "Blake",
            email: "siennablake@icloud.com",
            address: "17 Ocean Breeze Lane",
            zipCode: "33701", phone: "727-456-7890",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Orion",
            lastName: "Knight",
            email: "orionknight@icloud.com",
            address: "94 Sunset Trail",
            zipCode: "33602", phone: "813-987-6543",
            paidBill: true
        ),
        CustomerModel(
            firstName: "Jade",
            lastName: "Nguyen",
            email: "jadenguyen@icloud.com",
            address: "10 Lotus Park Drive",
            zipCode: "34748", phone: "352-321-8765",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Miles",
            lastName: "Raynor",
            email: "milesraynor@icloud.com",
            address: "88 Pineapple Grove",
            zipCode: "33401", phone: "561-654-3210",
            paidBill: true
        )
    ]
}
