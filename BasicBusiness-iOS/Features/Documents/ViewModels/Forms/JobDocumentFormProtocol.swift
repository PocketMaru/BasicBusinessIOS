import Foundation

@MainActor
protocol JobDocumentFormProtocol: AnyObject {
    associatedtype Document: JobDocumentProtocol
    associatedtype Draft: JobDocumentDraftProtocol
    
    var mode: FormMode { get }
    
    var original: Draft { get }
    var draft: Draft { get set }
    
    func loadIndustryFields(for industry: IndustryType)
    
    func validateFields() -> Bool
    func cancelEdits()
    func clearErrors()
    
    func convertDraftToDocument(_ draft: Draft ) -> Document?
    @discardableResult
    func trySubmit() -> Bool
}

extension JobDocumentFormProtocol {
    
    func cleanDraft(_ draft: Draft) -> Draft {
        var copy = draft
        copy.customFields = cleanCustomFields(copy.customFields)
        copy.pricingMethods = cleanPricingMethods(copy.pricingMethods)
        return copy
    }
    
    func cleanCustomFields(_ customFields: [CustomFieldModel]) -> [CustomFieldModel] {
        customFields.filter {
            !$0.label.trimmingCharacters(in: .whitespaces).isEmpty ||
            $0.value != nil
        }
    }
    
    func cleanPricingMethods(_ pricingMethods: [PricingMethodModel]) -> [PricingMethodModel] {
        pricingMethods.filter {
            $0.amount != nil ||
            $0.rate != nil
        }
    }
}
