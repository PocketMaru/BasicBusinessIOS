import Foundation

@MainActor
@Observable
final class QuoteFeatureVM {
    var allQuotes: [QuoteModel] = []
    private let saveQuote = SaveQuote()
    
    init () {
        do {
            allQuotes = try saveQuote.load()
        } catch {
            allQuotes = []
        }
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
            throw SaveError.writeFailed(reason: "Invalid index \(index)")
        }
        let quoteToRemove = allQuotes[index]
        allQuotes = try saveQuote.delete(
            quote: quoteToRemove,
            currentList: allQuotes
        )
    }
    
    func quotes(for customerID: UUID) -> [QuoteModel] {
        allQuotes.filter { $0.customerID == customerID }
    }
}
