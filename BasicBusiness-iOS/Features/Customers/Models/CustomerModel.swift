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
    var fullName: String? {
        "\(firstName) \(lastName)"
    }
    /// Returns `firstName` if `lastName` is empty (after trimming whitespace); otherwise, returns "firstName lastName".
    var displayName: String {
        lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
        firstName :
        "\(firstName) \(lastName)"
    }
    /// Date customer is added to storage.
    var loyaltyDate: Date = Date()
    var quotes: [QuoteModel] = []
    var invoices: [InvoiceModel] = []
    
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
