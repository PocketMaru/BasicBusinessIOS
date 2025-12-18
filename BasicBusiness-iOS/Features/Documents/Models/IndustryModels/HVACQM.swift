import Foundation

struct HVACQM: Codable, Equatable, Hashable {
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HVACQM {
    static let empty = HVACQM(pricingMethods: [])
}
