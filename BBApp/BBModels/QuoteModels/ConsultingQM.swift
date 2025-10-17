//
//  ConsultingQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct ConsultingQM {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension ConsultingQM {
    static let empty = ConsultingQM(pricingMethod: [.none])
}
