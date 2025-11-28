import Foundation

enum PricingMethodType: String, CaseIterable, Hashable, Codable {
    case fixedRate
    case squareFootage
    case liquidSolution
    case subscription
    case none
}

struct PricingMethod: Identifiable, Codable, Hashable {
    let id: UUID
    var type: PricingMethodType
    
    var amount: Double?
    var rate: Double?
    
    init (
        id: UUID = UUID(),
        type: PricingMethodType,
        amount: Double? = nil,
        rate: Double? = nil
    ) {
        self.id = id
        self.type = type
        self.amount = amount
        self.rate = rate
    }
}
