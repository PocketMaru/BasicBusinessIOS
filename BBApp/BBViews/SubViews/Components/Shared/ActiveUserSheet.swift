//
//  ActiveUserSheet.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import Foundation

enum ActiveUserSheet: Identifiable, Equatable {
    case user, addCustomer, addCustomerFromQuote
    
    var id: String {
        switch self {
        case .user: return "user"
        case .addCustomer: return "addCustomer"
        case .addCustomerFromQuote: return "addCustomerFromQuote"
        }
    }
}

