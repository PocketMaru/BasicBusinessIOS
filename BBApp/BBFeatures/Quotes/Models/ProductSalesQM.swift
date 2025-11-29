import Foundation

struct ProductSalesQM: Codable, Equatable, Hashable {
    var item: String?
    var quantity: Int?
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension ProductSalesQM {
    static let empty = ProductSalesQM(pricingMethod: [])
}
