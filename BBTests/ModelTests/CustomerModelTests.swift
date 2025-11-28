@testable import BasicBusiness
import Testing
import Foundation


final class CustomerModelTests {
    
    @Test
    func testCustomerInitializer() {
        let id = UUID()
        let firstName = "Joshua"
        let lastName = "Hauer"
        let email = "Joshuahauer@icloud.com"
        let address = "43 Ginger Circle"
        let zipCode = "34748"
        let phone = "(352) 272-2099"
        let paidBill = true
        let loyaltyDate = Date()
        let quotes: [QuoteModel] = []
        let invoices: [InvoiceModel] = []
        
        let customer = CustomerModel(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            zipCode: zipCode,
            phone: phone,
            paidBill: paidBill,
            loyaltyDate: loyaltyDate,
            quotes: quotes,
            invoices: invoices
        )
        #expect(customer.id == id)
        #expect(customer.firstName == firstName)
        #expect(customer.lastName == lastName)
        #expect(customer.email == email)
        #expect(customer.address == address)
        #expect(customer.zipCode == zipCode)
        #expect(customer.phone == phone)
        #expect(customer.paidBill == paidBill)
        #expect(customer.loyaltyDate == loyaltyDate)
        #expect(customer.quotes.isEmpty)
        #expect(customer.invoices.isEmpty)
        #expect(customer.fullName == "\(firstName) \(lastName)")
    }
}
