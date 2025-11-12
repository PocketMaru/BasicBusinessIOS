//
//  LandscapeQM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/20/25.
//

import Foundation
// These represent each industries specific fields
// Gives us the ability to calculate additions and add them
// to total cost or provide additional information. 
struct LandscapeQM: Codable, Equatable, Hashable {
    var pricingMethod: [PricingMethod]
    var totalCost: Double {
        pricingMethod.reduce(0) { $0 + $1.calculateTotal()}
    }
}
extension LandscapeQM {
    static let empty = LandscapeQM(pricingMethod: [.none])
}
