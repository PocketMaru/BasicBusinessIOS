import Foundation

struct LandscapeQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}
extension LandscapeQM {
    static let empty = LandscapeQM(pricingMethod: [])
}
