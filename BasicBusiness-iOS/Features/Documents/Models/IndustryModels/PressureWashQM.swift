import Foundation

struct PressureWashQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethodModel]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension PressureWashQM {
    static let empty = PressureWashQM(pricingMethod: [])
}
