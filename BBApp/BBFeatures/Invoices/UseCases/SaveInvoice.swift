import Foundation

protocol SaveInvoiceUseCase {
    
    func create(
        draft: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel]
    
    func update(
        invoice: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel]
    
    func delete(
        invoice: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel]
}

final class SaveInvoice: SaveInvoiceUseCase {
    private let fileStorage: FileStorageManager
    private let fileName = "invoices.json"
    
    init(fileStorage: FileStorageManager) {
        self.fileStorage = fileStorage
    }
    
    func create(
        draft: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel] {
        if currentList.contains(where: { $0.id == draft.id }) {
            throw SaveError.writeFailed(reason: "Duplicate Invoice ID")
        }
        var updatedList = currentList + [draft]
        try fileStorage.save(updatedList, as: fileName)
        return updatedList
    }
    
    func update(
        invoice: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel] {
        var snapshot = currentList
        guard let index = snapshot.firstIndex(where: { $0.id == invoice.id }) else {
            throw SaveError.writeFailed(reason: "Invoice not found")
        }
        snapshot[index] = invoice
        try fileStorage.save(snapshot, as: fileName)
        return snapshot
    }
    
    func delete(
        invoice: InvoiceModel,
        currentList: [InvoiceModel]
    ) throws -> [InvoiceModel] {
        var updatedList = currentList
        guard let index = updatedList.firstIndex(where: { $0.id == invoice.id }) else {
            throw SaveError.writeFailed(reason: "Invoice not found")
        }
        updatedList.remove(at: index)
        try fileStorage.save(updatedList, as: fileName)
        return updatedList
    }
}
