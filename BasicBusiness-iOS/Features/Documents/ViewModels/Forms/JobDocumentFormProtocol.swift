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
    
    func cleanDraft(_ customFields: [CustomFieldModel]) -> [CustomFieldModel] {
        draft.customFields.filter {
            !$0.label.trimmingCharacters(in: .whitespaces).isEmpty ||
            $0.value != nil
        }
    }
}
