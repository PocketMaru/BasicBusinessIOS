import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class InvoiceFormVM: JobDocumentFormProtocol {
    typealias Document = InvoiceModel
    typealias Draft = InvoiceDraftModel
    
    let mode: FormMode
    
    private(set) var original: InvoiceDraftModel
    var draft: InvoiceDraftModel
    
    private let onSubmit: (Document) throws -> Void
    
    var customerError: String? = nil
    var serviceTypeError: String? = nil
    var pricingMethodError: String? = nil
    var customFieldError: String? = nil
    var generalError: String? = nil
    var showAlert: Bool = false
    
    init(
        invoice: Draft,
        mode: FormMode,
        onSubmit: @escaping (Document) throws -> Void
    ) {
        self.original = invoice
        self.draft = invoice
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
        customerError = draft.customerID == nil ? "Please select a customer." : nil
        serviceTypeError = draft.serviceType == .none ? "Please select a service." : nil
        pricingMethodError = draft.pricingMethods.isEmpty ? "Please select a pricing method." : nil
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
    
    func clearErrors() {
        customerError = nil
        serviceTypeError = nil
        pricingMethodError = nil
        customFieldError = nil
        generalError = nil
    }

    func convertDraftToDocument(_ draft: Draft) -> Document? {
        guard let customerID = draft.customerID else { return nil }
        return InvoiceModel(
            id: draft.id,
            customerID: customerID,
            industryType: draft.industryType,
            serviceType: draft.serviceType,
            selectedCustomService: draft.selectedCustomService,
            pricingMethods: draft.pricingMethods,
            notes: draft.notes,
            subscriptionTotal: draft.subscriptionTotal,
            laborCost: draft.laborCost,
            customFields: draft.customFields,
            jobDocumentType: draft.jobDocumentType,
            documentDate: draft.documentDate,
            documentDueDate: draft.documentDueDate,
            documentInstallationDate: draft.documentInstallationDate,
            documentServiceDate: draft.documentServiceDate,
            customDateRange: draft.customDateRange,
            documentMaterials: draft.documentMaterials
        )
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        guard validateFields() else { return false }
        guard var document = convertDraftToDocument(draft) else { return false }
        
        document.customFields = cleanDraft(document.customFields)
        do {
            try onSubmit(document)
            return true
        } catch {
            generalError = error.localizedDescription
            showAlert = true
            return false
        }
    }
}
