import Foundation

@MainActor
@Observable
final class InvoiceFeatureVM {
    var allInvoices: [InvoiceModel] = []
    private let saveInvoice = ModelStorageUseCase<InvoiceModel>(filename: "invoices.json")
    
    init() {
        do {
            allInvoices = try saveInvoice.load()
        } catch {
            allInvoices = []
        }
    }
    
    func addInvoice(from draft: InvoiceModel) throws {
        let newInvoice = try saveInvoice.create(
            newModel: draft,
            currentList: allInvoices
        )
        allInvoices = newInvoice
    }
    
    func updateInvoice(from draft: InvoiceModel) throws {
        guard let _ = allInvoices.firstIndex(where: { $0.id == draft.id }) else {
            throw SaveError.writeFailed(reason: "Invoice not found")
        }
        let updated = try saveInvoice.update(
            updated: draft,
            currentList: allInvoices
        )
        allInvoices = updated
    }
    
    func deleteInvoice(at index: Int) throws {
        guard allInvoices.indices.contains(index) else {
            throw SaveError.writeFailed(reason: "Invalid index \(index)")
        }
        let invoiceToRemove = allInvoices[index]
        allInvoices = try saveInvoice.delete(
            model: invoiceToRemove,
            currentList: allInvoices
        )
    }
    
    func invoiceSearchByID(for customerID: UUID) -> [InvoiceModel] {
        allInvoices.filter { $0.customerID == customerID }
    }
}
