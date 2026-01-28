import Foundation

@MainActor
@Observable
final class CustomerFeatureVM {
    var allCustomers: [CustomerModel] = []
    private let saveCustomer = ModelStorageUseCase<CustomerModel>(filename: "customers.json")
    init() {
        do {
            allCustomers = try saveCustomer.load()
        } catch {
            allCustomers = []
        }
    }
    
    func addCustomer(from newCustomer: CustomerModel) throws {
        let updatedList = try saveCustomer.create(newModel: newCustomer, currentList: allCustomers)
        allCustomers = updatedList
    }
    
    func updateCustomer(from newCustomer: CustomerModel) throws {
        let updated = try saveCustomer.update(updated: newCustomer, currentList: allCustomers)
        allCustomers = updated
    }
    
    func removeCustomer(at index: Int) throws {
        guard allCustomers.indices.contains(index) else { return }
        let customerToRemove = allCustomers[index]
        allCustomers = try saveCustomer.delete(
            model: customerToRemove,
            currentList: allCustomers
        )
    }
    
    func customerSearchByID(with customerID: UUID) -> CustomerModel? {
        allCustomers.first(where: { $0.id == customerID })
    }
}
