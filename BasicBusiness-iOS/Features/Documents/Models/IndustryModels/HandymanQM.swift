import Foundation

struct HandymanQM: Codable, Equatable, Hashable {
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HandymanQM {
    static let empty = HandymanQM(pricingMethods: [])
}
