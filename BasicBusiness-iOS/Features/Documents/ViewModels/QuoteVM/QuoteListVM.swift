import Foundation
import Observation

@MainActor
@Observable
final class QuoteListVM {
    var allQuotes: [QuoteModel] = []
    var customerListVM: CustomerListVM
    var materialCatalogVM: MaterialListVM
    
    private let saveQuote: SaveQuoteUseCase
    private let quoteListStorage: FileStorageManager
    
    init(
        customerListVM: CustomerListVM,
        materialCatalogVM: MaterialListVM
    ) {
        self.customerListVM = customerListVM
        self.materialCatalogVM = materialCatalogVM
        
        self.quoteListStorage = FileStorageManager()
        self.saveQuote = SaveQuote(fileStorage: quoteListStorage)
        
        do {
            self.allQuotes = try quoteListStorage.load(from: "quotes.json")
        } catch(let e) {
            print(e)
            self.allQuotes = []
        }
    }
    
    func addVM() -> QuoteFormVM {
        print("Creating addVM for new quote")
        let vm = QuoteFormVM(
            quote: QuoteModel(),
            mode: .add,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: materialCatalogVM.allMaterials,
            onSubmit: { [weak self] draft in
                try self?.addQuote(from: draft)
            }
        )
        return vm
    }
    
    func editVM(with newQuote: QuoteModel) -> QuoteFormVM {
        print("Cash MISS -> creating VM for \(newQuote.id)")
        let vm = QuoteFormVM(
            quote: newQuote,
            mode: .edit,
            availableCustomers: customerListVM.allCustomers,
            savedMaterials: materialCatalogVM.allMaterials,
            onSubmit: { [weak self] draft in
                try self?.updateQuote(from: draft)
            }
        )
        return vm
    }
    
    func addQuote(from draft: QuoteModel) throws {
        let newQuote = try saveQuote.create(
            draft: draft,
            currentList: allQuotes
        )
        allQuotes = newQuote
    }
    
    func updateQuote(from draft: QuoteModel) throws {
        guard let _ = allQuotes.firstIndex(where: { $0.id == draft.id }) else {
            throw SaveError.writeFailed(reason: "Quote not found")
        }
        let updated = try saveQuote.update(
            quote: draft,
            currentList: allQuotes
        )
        allQuotes = updated
    }
    
    func deleteQuote(at index: Int) throws {
        guard allQuotes.indices.contains(index) else {
            print("Invalid index \(index) for removal")
            return
        }
        let quoteToRemove = allQuotes[index]
        do {
            allQuotes = try saveQuote.delete(
                quote: quoteToRemove,
                currentList: allQuotes
            )
        } catch {
            print("Failed to delete quote: \(error)")
        }
    }
    
    func quotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
}
