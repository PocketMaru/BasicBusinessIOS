import Foundation

struct HandymanQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethodModel]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HandymanQM {
    static let empty = HandymanQM(pricingMethod: [])
}
