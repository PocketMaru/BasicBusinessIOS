import Foundation
import Observation

@MainActor
@Observable
final class InvoiceListVM {
    let invoiceFeatureVM: InvoiceFeatureVM
    let customerFeatureVM: CustomerFeatureVM
    var materialFeatureVM: MaterialFeatureVM
    
    init(
        invoiceFeatureVM: InvoiceFeatureVM,
        customerFeatureVM: CustomerFeatureVM,
        materialFeatureVM: MaterialFeatureVM,
    ) {
        self.invoiceFeatureVM = invoiceFeatureVM
        self.customerFeatureVM = customerFeatureVM
        self.materialFeatureVM = materialFeatureVM
    }
    
    func addVM() -> InvoiceFormVM {
        print("Creating addVM for new invoice")
        let vm = InvoiceFormVM(
            invoice: InvoiceModel(),
            mode: .add,
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
            onSubmit: { [weak self] draft in
                try self?.updateInvoice(from: draft)
            }
        )
        return vm
    }
    
    func addInvoice(from draft: InvoiceModel) throws {
        try invoiceFeatureVM.addInvoice(from: draft)
    }
    
    func updateInvoice(from draft: InvoiceModel) throws {
        try invoiceFeatureVM.updateInvoice(from: draft)
    }
    
    func deleteInvoice(at index: Int) {
        do {
            try invoiceFeatureVM.deleteInvoice(at: index)
        } catch {
            print("This will be an alert")
        }
    }
}
