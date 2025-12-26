import Foundation
import Observation

@MainActor
@Observable
final class CustomerListVM {
    let customerFeatureVM: CustomerFeatureVM
    
    var paidCustomers: [CustomerModel] {
        customerFeatureVM.allCustomers.filter { $0.paidBill == true }
    }
    var unpaidCustomers: [CustomerModel] {
        customerFeatureVM.allCustomers.filter { $0.paidBill == false }
    }
    var newCustomerFromQuote: ((CustomerModel) -> Void)? = nil
    
    func getCustomer(for id: UUID) -> CustomerModel? {
        customerFeatureVM.allCustomers.first { $0.id == id }
    }
    
    init(customerFeatureVM: CustomerFeatureVM) {
        self.customerFeatureVM = customerFeatureVM
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
        try customerFeatureVM.addCustomer(from: draft)
    }
    
    func updateCustomer(from draft: CustomerModel) throws {
        try customerFeatureVM.updateCustomer(from: draft)
    }
    
    func removeCustomer(at index: Int) {
        do {
            try customerFeatureVM.removeCustomer(at: index)
        } catch {
            print("This will be an alert")
        }
    }
    
    func searchCustomer(by name: String) -> [CustomerModel] {
        let query = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        print("Query is \(query) | Total Customers is \(customerFeatureVM.allCustomers.count)")
        guard !query.isEmpty else {
            return customerFeatureVM.allCustomers
        }
        return customerFeatureVM.allCustomers.filter {
            let fullName = "\($0.firstName) \($0.lastName)".lowercased()
            return fullName.contains(query)
        }
    }
}
