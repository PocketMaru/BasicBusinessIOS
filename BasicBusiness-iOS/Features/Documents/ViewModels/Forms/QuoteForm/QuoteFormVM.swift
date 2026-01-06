import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class QuoteFormVM: JobDocumentFormProtocol {
    typealias Document = QuoteModel
    
    let mode: FormMode
    
    private(set) var original: QuoteModel
    var draft: QuoteModel
    
    private let onSubmit: (QuoteModel) throws -> Void
    
    var serviceTypeError: String? = nil
    var pricingMethodError: String? = nil
    var customFieldError: String? = nil
    var generalError: String? = nil
    var showAlert: Bool = false
    
    init(
        quote: QuoteModel,
        mode: FormMode,
        onSubmit: @escaping (QuoteModel) throws -> Void
    ) {
        self.original = quote
        self.draft = quote
        self.mode = mode
        self.onSubmit = onSubmit
    }
    
    func loadIndustryFields(for industry: IndustryType) {
        switch industry {
        case .landscaping:
            draft.pricingMethods = [
                PricingMethodModel(type: .squareFootage)
            ]

        case .consulting, .productSales, .handyman, .HVAC, .none:
            draft.pricingMethods = [
                PricingMethodModel(type: .fixedRate)
            ]

        case .pressureWashing:
            draft.pricingMethods = [
                PricingMethodModel(type: .liquidSolution)
            ]
        }
    }
    
    func validateFields() -> Bool {
        serviceTypeError = draft.serviceType == .none ? "Please select a service." : nil
        pricingMethodError = draft.pricingMethods.isEmpty ? "Please select a pricing method." : nil
        customFieldError = nil
        
        return [
            serviceTypeError,
            pricingMethodError,
            customFieldError,
        ].allSatisfy { $0 == nil }
    }
    
    func cancelEdits() {
        draft = original
    }
    
    func clearErrors() {
        serviceTypeError = nil
        pricingMethodError = nil
        customFieldError = nil
        generalError = nil
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        guard validateFields() else { return false }
        do {
            try onSubmit(draft)
            return true
        } catch {
            generalError = error.localizedDescription
            showAlert = true
            return false
        }
    }
}
