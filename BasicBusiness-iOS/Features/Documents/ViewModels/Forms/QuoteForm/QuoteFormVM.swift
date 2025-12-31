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
    
    func addPricingMethod(_ type: PricingMethodType ) {
        draft.pricingMethods.append(
                PricingMethodModel(type: type)
            )
    }
    
    func removePricingMethod(id: UUID) {
        draft.pricingMethods.removeAll(where: { $0.id == id })
    }
    
    func addCustomField(_ field: CustomField) {
        draft.customFields.append(field)
    }
    
    func removeCustomField(id: UUID) {
        draft.customFields.removeAll(where: { $0.id == id })
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
// MARK: - Form field bindings
extension QuoteFormVM: PricingMethodProviding {
    
    var pricingMethods: [PricingMethodModel] {
        get { draft.pricingMethods }
        set { draft.pricingMethods = newValue }
    }
    
    var pricingMethodsBinding: Binding<[PricingMethodModel]> {
        Binding(
            get: { self.draft.pricingMethods },
            set: { self.draft.pricingMethods = $0 }
        )
    }
    
    var selectedServiceBinding: Binding<ServiceType> {
        Binding(
            get: { self.draft.serviceType },
            set: { self.draft.serviceType = $0 }
        )
    }
    
    var selectedCustomServiceBinding: Binding<String> {
        Binding(
            get: { self.draft.selectedCustomService },
            set: { self.draft.selectedCustomService = $0 }
        )
    }
    
    var notesBinding: Binding<String> {
        Binding(
            get: { self.draft.notes ?? "" },
            set: { self.draft.notes = $0 }
        )
    }
    
    var customFields: [CustomField] {
        get { draft.customFields }
        set { draft.customFields = newValue }
    }
    
    var customFieldsBinding: Binding<[CustomField]> {
        Binding(
            get: { self.draft.customFields },
            set: { self.draft.customFields = $0 }
        )
    }
    
    var creationDateBinding: Binding<Date> {
        Binding(
            get: { self.draft.documentDate },
            set: { self.draft.documentDate = $0 }
        )
    }
    
    var dueDateBinding: Binding<Date> {
        Binding(
            get: { self.draft.documentDueDate },
            set: { self.draft.documentDueDate = $0 }
        )
    }
    
    var installationDateBinding: Binding<Date> {
        Binding(
            get: { self.draft.documentInstallationDate ?? Date() },
            set: { self.draft.documentInstallationDate = $0 }
        )
    }
    
    var serviceDateBinding: Binding<Date> {
        Binding(
            get: { self.draft.documentServiceDate ?? Date() },
            set: { self.draft.documentServiceDate = $0 }
        )
    }
    
    var customDateRangeBinding: Binding<Set<DateComponents>> {
        Binding(
            get: { self.draft.customDateRange },
            set: { self.draft.customDateRange = $0}
        )
    }
}
