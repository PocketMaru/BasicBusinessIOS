//
//  HandymanQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct HandymanQM {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HandymanQM {
    static let empty = HandymanQM(pricingMethod: [.none])
}
