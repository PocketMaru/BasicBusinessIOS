import Foundation

struct CustomerModel: Identifiable, Codable, Equatable, Hashable {

    var id: UUID = UUID()
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var address: String? = nil
    var zipCode: String? = nil
    var phone: String = ""
    // TODO: This paidBill logic will be replaced with the customer payment status enum.
    // TODO: it will have computed properties that determine the value based on open invoices/closed and quotes open
    var paidBill: Bool? = false
    /// Returns `firstName` if `lastName` is empty (after trimming whitespace); otherwise, returns "firstName lastName".
    var displayName: String {
        lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        firstName :
        "\(firstName) \(lastName)"
    }
    /// Date customer is added to storage.
    var loyaltyDate: Date = Date()
    
}

extension CustomerModel {
    static func mock(
        id: UUID = UUID(),
        firstName: String = "Joshua",
        lastName: String = "Hauer",
        email: String = "joshua@example.com",
        address: String? = "43 Ginger Circle",
        zipCode: String? = "90210",
        phone: String = "555-555-5555",
        paidBill: Bool? = false,
    ) -> CustomerModel {
        var mockModel = CustomerModel()
        
        mockModel.id = id
        mockModel.firstName = firstName
        mockModel.lastName = lastName
        mockModel.email = email
        mockModel.address = address
        mockModel.zipCode = zipCode
        mockModel.phone = phone
        mockModel.paidBill = paidBill
        
        return mockModel
    }
    
    static var mockList: [CustomerModel] {
        [
            .mock(
                id: UUID(),
                firstName: "Joshua",
                lastName: "Hauer",
                email: "Joshuahauer@icloud.com",
                address: "43 Ginger Circle",
                zipCode: "34748",
                phone: "352 272 2099",
                paidBill: false
                ),
            .mock(
                id: UUID(),
                firstName: "Kaley",
                lastName: "Hauer",
                email: "Joshuahauer@icloud.com",
                address: "43 Ginger Circle",
                zipCode: "34748",
                phone: "352 272 2096",
                paidBill: false
                ),
            .mock(
                id: UUID(),
                firstName: "Raven",
                lastName: "Hauer",
                email: "Joshuahauer@icloud.com",
                address: "43 Ginger Circle",
                zipCode: "34748",
                phone: "352 272 2097",
                paidBill: false
                ),
            .mock(
                id: UUID(),
                firstName: "Valkyrie",
                lastName: "Hauer",
                email: "Joshuahauer@icloud.com",
                address: "43 Ginger Circle",
                zipCode: "34748",
                phone: "352 272 2098",
                paidBill: false
                ),
            .mock(
                id: UUID(),
                firstName: "Goose",
                lastName: "Baba",
                email: "Juicegabba@icloud.com",
                address: "43 Ginger Circle",
                zipCode: "34748",
                phone: "789 654 3211",
                paidBill: false
                ),
        ]
    }
}

// TODO: This enum will determine the payment status of a customer based on open invoices and quotes tied to the customer.
enum CustomerPaymentStatus {
    case noActivity
    case quoted
    case unpaid
    case paid
    case late
    case paidLate
}
