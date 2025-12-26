import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class QuoteFormVM: JobDocumentFormProtocol {
    typealias Document = QuoteModel
    
    let mode: FormMode

    private let onSubmit: (QuoteModel) throws -> Void
    
    private(set) var original: QuoteModel
    var draft: QuoteModel
    
    var savedMaterials: [MaterialModel] = []
    
    var customerSelection: [CustomerModel] = []
    var selectedCustomer: CustomerModel? = nil
    
    var serviceTypeError: String? = nil
    var pricingMethodError: String? = nil
    var customerError: String? = nil
    var customFieldError: String? = nil
    var generalError: String? = nil
    var showAlert: Bool = false
    
    
    init(
        quote: QuoteModel,
        mode: FormMode,
        availableCustomers: [CustomerModel],
        savedMaterials: [MaterialModel],
        onSubmit: @escaping (QuoteModel) throws -> Void
    ) {
        self.original = quote
        self.draft = quote
        self.mode = mode
        self.customerSelection = availableCustomers
        self.savedMaterials = savedMaterials
        self.onSubmit = onSubmit
    }
    
    func loadIndustryFields(for industry: IndustryType) {
        switch industry {
        case .landscaping:
            draft.pricingMethods = [PricingMethodModel(type: .squareFootage, amount: 0, rate: 0)]
            
        case .consulting, .productSales, .handyman, .HVAC, .none:
            draft.pricingMethods = [PricingMethodModel(type: .fixedRate, amount: 0)]
            
        case .pressureWashing:
            draft.pricingMethods = [PricingMethodModel(type: .liquidSolution, amount: 0, rate: 0)]
        }
    }
    
    func addIndustryField(_ type: PricingMethodType ) {
        switch type {
        case .fixedRate:
            draft.pricingMethods.append(PricingMethodModel(type: .fixedRate, amount: 0))
        case .squareFootage:
            draft.pricingMethods.append(PricingMethodModel(type: .squareFootage, amount: 0, rate: 0))
        case .liquidSolution:
            draft.pricingMethods.append(PricingMethodModel(type: .liquidSolution, amount: 0, rate: 0))
        case .subscription:
            draft.pricingMethods.append(PricingMethodModel(type: .subscription , amount: 0))
        case .none:
            return
        }
    }
    
    func selectCustomer(_ customer: CustomerModel) {
        selectedCustomer = customer
        draft.customerID = customer.id
    }
    
    func addMaterialToQuote(from savedMaterial: MaterialModel, markAsExpense: Bool = false) {
        let quoteMaterial = MaterialExpenseModel(from: savedMaterial, addedAsExpense: markAsExpense)
        draft.materialExpenses.append(quoteMaterial)
    }
    
    func validateFields() -> Bool {
        serviceTypeError = draft.serviceType == .none ? "Please select a service." : nil
        pricingMethodError = draft.pricingMethods.isEmpty ? "Please select a pricing method." : nil
        customerError = selectedCustomer == nil ? "Please select a customer" : nil
        customFieldError = nil
        
        return [
            customerError,
            serviceTypeError,
            pricingMethodError,
            customFieldError,
        ].allSatisfy { $0 == nil }
    }
    
    func cancelEdits() {
        draft = original
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        let isValid = validateFields()
        if isValid {
            if let selected = selectedCustomer {
                draft.customerID = selected.id
            }
            do {
                try onSubmit(draft)
                return true
            } catch {
                generalError = error.localizedDescription
                showAlert = true
                return false
            }
        }
        return false
    }
    
    func clearErrors() {
        customerError = nil
        serviceTypeError = nil
        pricingMethodError = nil
        customFieldError = nil
        generalError = nil
    }
}

extension QuoteFormVM {
    var pricingMethodsBinding: Binding<[PricingMethodModel]> {
        Binding(
            get: { self.draft.pricingMethods },
            set: { self.draft.pricingMethods = $0 }
        )
    }
}
extension QuoteFormVM: PricingMethodProviding {
    var pricingMethods: [PricingMethodModel] {
        get { draft.pricingMethods }
        set { draft.pricingMethods = newValue }
    }
}
