//
//  BBQuoteViewModel.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/17/25.
//

import Foundation

@Observable
final class QuoteViewModel {
    var quote: [QuoteModel]
    
    init(quote: [QuoteModel]) {
        self.quote = quote
    }
    
    
}
