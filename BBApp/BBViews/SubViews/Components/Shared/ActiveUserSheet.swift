//
//  ActiveUserSheet.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import Foundation

enum ActiveUserSheet: Identifiable {
    case user, addCustomer
    
    var id: String {
        switch self {
        case .user: return "user"
        case .addCustomer: return "addCustomer"
        }
    }
}

