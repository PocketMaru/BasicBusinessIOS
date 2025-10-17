//
//  HVACQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/21/25.
//

import Foundation

struct HVACQM {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension HVACQM {
    static let empty = HVACQM(pricingMethod: [.none])
}
