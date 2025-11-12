//
//  LandscapeView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/27/25.
//

import SwiftUI

struct LandscapeSectionView: View {
    @Bindable var quoteVM: QuoteVM
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach($quoteVM.draftQuote.pricingMethods, id: \.self) { $method in
                PricingMethodView(method: $method)
            }
        }
    }
}

