//
//  PressureWashQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation

struct PressureWashQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}

extension PressureWashQM {
    static let empty = PressureWashQM(pricingMethod: [.none])
}
