//
//  CustomerVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/16/25.
//

import Foundation

@MainActor
@Observable
final class CustomerListVM {
    var allCustomers: [CustomerModel] = []
    var allQuotes: [QuoteModel] = []
    
    init() {
        self.allCustomers = loadCustomers()
    }
    
    func addCustomer(
        firstName: String,
        lastName: String,
        email: String,
        address: String?,
        zipCode: String?,
        phone: String,
        paidBill: Bool?
    ){
        let newCustomer = CustomerModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            address: address,
            zipCode: zipCode,
            phone: phone,
            paidBill: paidBill ?? false
        )
        allCustomers.append(newCustomer)
        saveCustomers(allCustomers)
    }
    
    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        return allCustomers.filter {
            $0.firstName.lowercased().contains(query) ||
            $0.lastName.lowercased().contains(query) ||
            "\($0.firstName) \($0.lastName)".lowercased().contains(query)
        }
    }
    
    func removeCustomer(at index: Int){
        allCustomers.remove(at: index)
        saveCustomers(allCustomers)
    }
    
    func showAllCustomerQuotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
    
    func updateCustomer(with updated: CustomerModel) {
        if let index = allCustomers.firstIndex(where: { $0.id == updated.id }) {
            allCustomers[index] = updated
            saveCustomers(allCustomers)
        }
    }
    
    func loadCustomers() -> [CustomerModel] {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: FileStorage.customerFileURL)
            let decoded = try decoder.decode([CustomerModel].self, from: data)
            return decoded
        } catch {
            print("Failed to load customers:", error)
            return []
        }
    }
    
    func saveCustomers(_ customers: [CustomerModel]) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(customers)
            try data.write(to: FileStorage.customerFileURL, options: [.atomicWrite])
            print("Saved to \(FileStorage.customerFileURL)")
        } catch {
            print("Failed to save customers:", error)
        }
    }
    
    func customerFileURL() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("customers.json")
    }
    
    func loadAndCleanCustomersFromDisk() {
        let url = customerFileURL()
        do {
            let data = try JSONEncoder().encode(allCustomers)
            try data.write(to: url)
            print("Saved customers to disk.")
        } catch {
            print("Failed to save customers to disk: \(error)")
        }
    }
}
