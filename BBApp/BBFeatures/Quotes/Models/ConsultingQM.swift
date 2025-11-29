import Foundation

struct ConsultingQM: Codable, Equatable, Hashable{
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension ConsultingQM {
    static let empty = ConsultingQM(pricingMethod: [])
}
