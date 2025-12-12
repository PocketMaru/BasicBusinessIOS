import Foundation

enum PricingMethodType: String, CaseIterable, Hashable, Codable {
    case fixedRate
    case squareFootage
    case liquidSolution
    case subscription
    case none
}

struct PricingMethodModel: Identifiable, Codable, Hashable {
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

extension PricingMethodModel {
    func calculateTotal() -> Double {
        switch type {
        case .fixedRate:
            return amount ?? 0
        case .squareFootage:
            return (amount ?? 0) * (rate ?? 0)
        case .liquidSolution:
            return (amount ?? 0) * (rate ?? 0)
        case .subscription:
            return amount ?? 0
        case .none:
            return 0
        }
    }
}
