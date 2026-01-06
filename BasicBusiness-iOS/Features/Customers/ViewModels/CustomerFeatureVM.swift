import Foundation

@MainActor
@Observable
final class CustomerFeatureVM {
    var allCustomers: [CustomerModel] = []
    private let saveCustomer = SaveCustomer()
    init() {
        do {
            allCustomers = try saveCustomer.load()
        } catch {
            allCustomers = []
        }
    }
    
    func addCustomer(from draft: CustomerModel) throws {
        let newCustomer = try saveCustomer.create(newCustomer: draft, currentList: allCustomers)
        allCustomers = newCustomer
    }
    
    func updateCustomer(from draft: CustomerModel) throws {
        guard let _ = allCustomers.firstIndex(where: { $0.id == draft.id}) else {
            throw SaveError.writeFailed(reason: "Customer not found")
        }
        let updated = try saveCustomer.update(updated: draft, currentList: allCustomers)
        allCustomers = updated
    }
    
    func removeCustomer(at index: Int) throws {
        guard allCustomers.indices.contains(index) else {
            throw SaveError.writeFailed(reason: "Invalid index \(index)")
        }
        let customerToRemove = allCustomers[index]
        allCustomers = try saveCustomer.delete(
            customer: customerToRemove,
            currentList: allCustomers
        )
    }
    
    func customerSearchByID(with customerID: UUID) -> CustomerModel? {
        allCustomers.first(where: { $0.id == customerID })
    }
}
