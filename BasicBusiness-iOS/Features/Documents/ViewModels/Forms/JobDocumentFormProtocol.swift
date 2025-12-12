import Foundation

@MainActor
protocol JobDocumentFormProtocol: AnyObject {
    associatedtype Document: JobDocumentProtocol
    
    var draft: Document { get set }
    var mode: FormMode { get }
    
    var customerSelection: [CustomerModel] { get }
    var selectedCustomer: CustomerModel? { get set }
    func selectCustomer(_ customer: CustomerModel)
    
    func loadIndustryFields(for industry: IndustryType)
    func addIndustryField(_ type: PricingMethodType)
    
    var savedMaterials: [MaterialModel] { get }
    
    func validateFields() -> Bool
    func cancelEdits()
    
    @discardableResult
    func trySubmit() -> Bool
}
