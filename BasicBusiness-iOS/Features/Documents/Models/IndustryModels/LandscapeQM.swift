import Foundation

struct LandscapeQM: Codable, Equatable, Hashable {
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}
extension LandscapeQM {
    static let empty = LandscapeQM(pricingMethods: [])
}
