import Foundation

struct ProductSalesQM: Codable, Equatable, Hashable {
    var item: String?
    var quantity: Int?
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension ProductSalesQM {
    static let empty = ProductSalesQM(pricingMethods: [])
}

extension ProductSalesQM: InIndustryDetailRenderable {}
