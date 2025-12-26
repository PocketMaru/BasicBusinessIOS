import Foundation
import SwiftUI

@MainActor
protocol PricingMethodProviding {
    var pricingMethods: [PricingMethodModel] { get set }
}

@MainActor
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

extension PricingMethodModel {

    static func make(_ type: PricingMethodType) -> PricingMethodModel {
        switch type {
        case .fixedRate:
            return PricingMethodModel(
                type: .fixedRate,
                amount: 0
            )

        case .squareFootage:
            return PricingMethodModel(
                type: .squareFootage,
                amount: 0,
                rate: 0
            )

        case .liquidSolution:
            return PricingMethodModel(
                type: .liquidSolution,
                amount: 0,
                rate: 0
            )

        case .subscription:
            return PricingMethodModel(
                type: .subscription,
                amount: 0
            )

        case .none:
            return PricingMethodModel(type: .none)
        }
    }
}
