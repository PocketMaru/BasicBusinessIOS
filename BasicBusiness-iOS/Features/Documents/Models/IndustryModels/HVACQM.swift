import Foundation

struct HVACQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethodModel]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HVACQM {
    static let empty = HVACQM(pricingMethod: [])
}
