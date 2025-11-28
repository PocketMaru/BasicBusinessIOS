import Observation

@MainActor
@Observable
final class CustomerListVM {
    var allCustomers: [CustomerModel] = []

    var allQuotes: [QuoteModel] = []
    
    var paidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill == true }
    }
    var unpaidCustomers: [CustomerModel] {
        allCustomers.filter { $0.paidBill == false }
    }
    var newCustomerFromQuote: ((CustomerModel) -> Void)? = nil
    
    private let saveCustomer: SaveCustomerUseCase
    private let customerListStorage: FileStorageManager
    
    init() {
        self.customerListStorage = FileStorageManager()
        self.saveCustomer = SaveCustomer(fileStorage: customerListStorage)
        
        do {
            self.allCustomers = try customerListStorage.load(from: "customers.json")
        } catch(let e) {
            print(e)
            self.allCustomers = []
        }
    }
    
    func addVM() -> CustomerFormVM {
        print("Creating AddVM for new customer")
        let vm = CustomerFormVM(
            customer: CustomerModel(),
            mode: .add,
            onSubmit: { [weak self] draft in
               try self?.addCustomer(from: draft)
            }
        )
        return vm
    }
    
    func addVM(onSubmit: @escaping (CustomerModel) throws -> Void) -> CustomerFormVM {
        print("Creating AddVM for new customer")
        let vm = CustomerFormVM(
            customer: CustomerModel(),
            mode: .add,
            onSubmit: onSubmit
        )
        return vm
    }
    
    func editVM(for customer: CustomerModel) -> CustomerFormVM {
        print("cache MISS → creating VM for \(customer.id)")
        let vm = CustomerFormVM(
            customer: customer,
            mode: .edit,
            onSubmit: { [weak self] draft in
               try self?.updateCustomer(from: draft)
            }
        )
        return vm
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
    
    func removeCustomer(at index: Int) {
        guard allCustomers.indices.contains(index) else {
            print("Invalid index \(index) for removal")
            return
        }
        let customerToRemove = allCustomers[index]
        do {
            allCustomers = try saveCustomer.delete(
                customer: customerToRemove,
                currentList: allCustomers
            )
        } catch {
            print("Failed to delete customer: \(error)")
        }
    }
    
    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        print("Query is \(query) | Total Customers is \(allCustomers.count)")
        guard !query.isEmpty else {
            return allCustomers
        }
        return allCustomers.filter {
            let fullName = "\($0.firstName) \($0.lastName)".lowercased()
            return fullName.contains(query)
        }
    }
}
