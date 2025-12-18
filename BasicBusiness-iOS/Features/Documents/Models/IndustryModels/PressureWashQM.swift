import Foundation

struct PressureWashQM: Codable, Equatable, Hashable {
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension PressureWashQM {
    static let empty = PressureWashQM(pricingMethods: [])
}
