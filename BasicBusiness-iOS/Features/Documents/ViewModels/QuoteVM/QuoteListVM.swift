import Foundation
import Observation

@MainActor
@Observable
final class QuoteListVM {
    let quoteFeatureVM: QuoteFeatureVM
    
    init(
        quoteFeatureVM: QuoteFeatureVM,
    ) {
        self.quoteFeatureVM = quoteFeatureVM
    }
    
    func addVM() -> QuoteFormVM {
        print("Creating addVM for new quote")
        let quote = QuoteDraftModel(
            documentType: .quote,
            industryType: .none
        )
        let vm = QuoteFormVM(
            quote: quote,
            mode: .add,
            onSubmit: { [weak self] draft in
                try self?.addQuote(from: draft)
            }
        )
        return vm
    }
    
    func editVM(with newQuote: QuoteDraftModel) -> QuoteFormVM {
        print("Cash MISS -> creating VM for \(newQuote.id)")
        let vm = QuoteFormVM(
            quote: newQuote,
            mode: .edit,
            onSubmit: { [weak self] draft in
                try self?.updateQuote(from: draft)
            }
        )
        return vm
    }
    
    func addQuote(from draft: QuoteModel) throws {
        try quoteFeatureVM.addQuote(from: draft)
    }
    
    func updateQuote(from draft: QuoteModel) throws {
        try quoteFeatureVM.updateQuote(from: draft)
    }
    
    func deleteQuote(at index: Int) {
        do {
            try quoteFeatureVM.deleteQuote(at: index)
        } catch {
            print("This will be an alert")
        }
    }
}
