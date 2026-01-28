import Foundation

@MainActor
@Observable
final class QuoteFeatureVM {
    var allQuotes: [QuoteModel] = []
    private let saveQuote = ModelStorageUseCase<QuoteModel>(filename: "quotes.json")
    
    init () {
        do {
            allQuotes = try saveQuote.load()
        } catch {
            allQuotes = []
        }
    }
    
    func addQuote(from draft: QuoteModel) throws {
        let newQuote = try saveQuote.create(
            newModel: draft,
            currentList: allQuotes
        )
        allQuotes = newQuote
    }
    
    func updateQuote(from draft: QuoteModel) throws {
        guard let _ = allQuotes.firstIndex(where: { $0.id == draft.id }) else {
            throw SaveError.writeFailed(reason: "Quote not found")
        }
        let updated = try saveQuote.update(
            updated: draft,
            currentList: allQuotes
        )
        allQuotes = updated
    }
    
    func deleteQuote(at index: Int) throws {
        guard allQuotes.indices.contains(index) else {
            throw SaveError.writeFailed(reason: "Invalid index \(index)")
        }
        let quoteToRemove = allQuotes[index]
        allQuotes = try saveQuote.delete(
            model: quoteToRemove,
            currentList: allQuotes
        )
    }
    
    func quoteSearchByID(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
}
