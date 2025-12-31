import Foundation

enum JobDocumentType: String, Codable, CaseIterable {
    case quote
    case invoice
}

protocol JobDocumentProtocol: Codable {
    var id: UUID { get set }
    var customerID: UUID { get set }
    
    var industryType: IndustryType { get set }
    
    var serviceType: ServiceType { get set }
    var selectedCustomService: String { get set }
    
    var pricingMethods: [PricingMethodModel] { get set }
    
    var notes: String? { get set }
    var subscriptionTotal: Double? { get set }
    var materialExpenses: [MaterialExpenseModel] { get set }

    var laborCost: LaborType? { get set }
    
    var customFields: [CustomField] { get set }

    var jobDocumentType: JobDocumentType { get set }
}

extension JobDocumentProtocol {
    var materialTotalCost: Double? {
        materialExpenses.map(\.unitCost).reduce(0, +)
    }
    
    var totalCost: Double {
        let materialCost = materialTotalCost ?? 0
        let laborCost = laborCost?.calculateTotal() ?? 0
        let customFieldCost = customFields.map { Double($0.value ?? 0) }.reduce(0, +)
        let subscriptionTotalCost = subscriptionTotal ?? 0
        let pricingMethodTotal = pricingMethods.reduce(0) { $0 + $1.calculateTotal() }
        return materialCost + laborCost + customFieldCost + subscriptionTotalCost + pricingMethodTotal
    }
}
