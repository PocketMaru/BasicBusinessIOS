import Foundation

@MainActor
protocol JobDocumentFormProtocol: AnyObject {
    associatedtype Document: JobDocumentProtocol
    
    var mode: FormMode { get }
    
    var draft: Document { get set }
    var original: Document { get }
    
    func loadIndustryFields(for industry: IndustryType)
    
    func validateFields() -> Bool
    func cancelEdits()
    func clearErrors()
    
    @discardableResult
    func trySubmit() -> Bool
}
