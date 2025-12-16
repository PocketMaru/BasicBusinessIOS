import Foundation

struct ConsultingQM: Codable, Equatable, Hashable{
    var pricingMethods: [PricingMethodModel]
    var totalCost: Double {
        pricingMethods.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension ConsultingQM {
    static let empty = ConsultingQM(pricingMethods: [])
}

extension ConsultingQM: InIndustryDetailRenderable {}
