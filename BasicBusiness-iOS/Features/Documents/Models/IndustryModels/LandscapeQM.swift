import Foundation

struct LandscapeQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethodModel]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}
extension LandscapeQM {
    static let empty = LandscapeQM(pricingMethod: [])
}
