import Foundation
import Observation

@MainActor
@Observable
final class InvoiceListVM {
    var allInvoices: [InvoiceModel] = []
    var customerListVM: CustomerListVM
    var materialCatalogVM: MaterialListVM
    
    private let saveInvoice: SaveInvoiceUseCase
    private let invoiceListStorage: FileStorageManager
    
    init(
        customerListVM: CustomerListVM,
        materialCatalogVM: MaterialListVM
    ) {
        self.customerListVM = customerListVM
        self.materialCatalogVM = materialCatalogVM
        
        self.invoiceListStorage = FileStorageManager()
        self.saveInvoice = SaveInvoice(fileStorage: invoiceListStorage)
        
        do {
            self.allInvoices = try invoiceListStorage.load(from: "invoices.json")
        } catch(let e) {
            print(e)
            self.allInvoices = []
        }
    }
    
    func addVM() -> InvoiceFormVM {
        print("Creating addVM for new invoice")
        let vm = InvoiceFormVM(
            invoice: InvoiceModel(),
            mode: .add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: materialCatalogVM.materialList,
            onSubmit: {[weak self] draft in
                try self?.addInvoice(from: draft)
            }
        )
        return vm
    }
    
    func editVM(with newInvoice: InvoiceModel) -> InvoiceFormVM {
        print("Cash MISS -> creating VM for \(newInvoice.id)")
        let vm = InvoiceFormVM(
            invoice: newInvoice,
            mode: .edit,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: materialCatalogVM.materialList,
            onSubmit: { [weak self] draft in
                try self?.updateInvoice(from: draft)
            }
        )
        return vm
    }
    
    func addInvoice(from draft: InvoiceModel) throws {
        let newInvoice = try saveInvoice.create(
            draft: draft,
            currentList: allInvoices
        )
        allInvoices = newInvoice
    }
    
    func updateInvoice(from draft: InvoiceModel) throws {
        guard let _ = allInvoices.firstIndex(where: { $0.id == draft.id }) else {
            throw SaveError.writeFailed(reason: "Invoice not found")
        }
        
        let updated = try saveInvoice.update(
            invoice: draft,
            currentList: allInvoices
        )
        allInvoices = updated
    }
    
    func deleteInvoice(at index: Int) throws {
        guard allInvoices.indices.contains(index) else {
            print("Invalid index \(index) for removal")
            return
        }
        let invoiceToRemove = allInvoices[index]
        do {
            allInvoices = try saveInvoice.delete(
                invoice: invoiceToRemove,
                currentList: allInvoices
            )
        } catch {
            print("Failed to delete invoice: \(error)")
        }
    }
    
    func invoices(for customerID: UUID) -> [InvoiceModel] {
        allInvoices.filter { $0.customerID == customerID }
    }
}
