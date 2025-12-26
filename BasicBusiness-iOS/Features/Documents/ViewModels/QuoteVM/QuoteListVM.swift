import Foundation
import Observation

@MainActor
@Observable
final class QuoteListVM {
    let quoteFeatureVM: QuoteFeatureVM
    let customerFeatureVM: CustomerFeatureVM
    let materialListVM: MaterialListVM
    
    init(
        quoteFeatureVM: QuoteFeatureVM,
        customerFeatureVM: CustomerFeatureVM,
        materialListVM: MaterialListVM,
    ) {
        self.quoteFeatureVM = quoteFeatureVM
        self.customerFeatureVM = customerFeatureVM
        self.materialListVM = materialListVM
    }
    
    func addVM() -> QuoteFormVM {
        print("Creating addVM for new quote")
        let vm = QuoteFormVM(
            quote: QuoteModel(),
            mode: .add,
            availableCustomers: customerFeatureVM.allCustomers,
            savedMaterials: materialListVM.allMaterials,
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
            availableCustomers: customerFeatureVM.allCustomers,
            savedMaterials: materialListVM.allMaterials,
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
    
    func quotes(for customerID: UUID) -> [QuoteModel] {
        quoteFeatureVM.allQuotes.filter { $0.customerID == customerID }
    }
}
