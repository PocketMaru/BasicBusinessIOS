//
//  QuoteVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

@Observable
final class QuoteVM {
    var quote: [QuoteModel]
    
    init(quote: [QuoteModel]) {
        self.quote = quote
    }
    
    
}
