//
//  CustomerModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/6/25.
//

import Foundation
/// Struct `CustomerModel` defines the customer data structure.
/// Extension to `CustomerModel` provides sample data for previews/testing.
struct CustomerModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var address: String? = nil
    var phone: String = ""
    var zipCode: String? = nil
    var paidBill: Bool? = false
    // MARK: - Pending Refactors
    // TODO: Replace all 'fullName` uses with `displayName` app-wide.
    // TODO: Consider making lastName optional if user editing stays flexible.
    // TODO: Audit views using fullName to clean up fallback logic.
    // When editing, `lastName` may be empty, so fullName looks awkward.
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
    // Returns `firstName` if `lastName` is empty (after trimming whitespace); otherwise, returns "firstName lastName".
    var displayName: String {
        lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        firstName :
        "\(firstName) \(lastName)"
    }
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
            phone: "352-272-2099",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Kaley",
            lastName: "Hauer",
            email: "Kaleyhauer@icloud.com",
            address: "43 Ginger Circle",
            phone: "408-808-2843",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Raven",
            lastName: "Hauer",
            email: "ravenhauer@icloud.com",
            address: "43 Ginger Circle",
            phone: "444-555-6666",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Valkyrie",
            lastName: "Hauer",
            email: "valkyriehauer@icloud.com",
            address: "43 Ginger Circle",
            phone: "333-222-1111",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Goose",
            lastName: "BABA",
            email: "goosebaba@icloud.com",
            address: "43 Ginger Circle",
            phone: "111-222-3333",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Leo",
            lastName: "Castro",
            email: "leocastro@icloud.com",
            address: "201 Palm Cove Drive",
            phone: "305-123-4567",
            zipCode: "33101",
            paidBill: true
        ),
        CustomerModel(
            firstName: "Sienna",
            lastName: "Blake",
            email: "siennablake@icloud.com",
            address: "17 Ocean Breeze Lane",
            phone: "727-456-7890",
            zipCode: "33701",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Orion",
            lastName: "Knight",
            email: "orionknight@icloud.com",
            address: "94 Sunset Trail",
            phone: "813-987-6543",
            zipCode: "33602",
            paidBill: true
        ),
        CustomerModel(
            firstName: "Jade",
            lastName: "Nguyen",
            email: "jadenguyen@icloud.com",
            address: "10 Lotus Park Drive",
            phone: "352-321-8765",
            zipCode: "34748",
            paidBill: false
        ),
        CustomerModel(
            firstName: "Miles",
            lastName: "Raynor",
            email: "milesraynor@icloud.com",
            address: "88 Pineapple Grove",
            phone: "561-654-3210",
            zipCode: "33401",
            paidBill: true
        )
    ]
}
