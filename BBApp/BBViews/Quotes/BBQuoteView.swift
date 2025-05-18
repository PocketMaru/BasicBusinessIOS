//
//  QuoteView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import SwiftUI

struct BBQuoteView: View {
    // Enumeration created to control quote view options
    // used instead of boolean options.
    enum QuoteViewMode {
        case residential
        case commercial
        case addCustomer
    }
    
    @Binding var customers: [BBCustomerModel]
    @Binding var businessStats: [BBBusinessStatsVM]
    @State private var newCustomer = BBCustomerModel()
    @State var quoteViewMode: QuoteViewMode = .addCustomer
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack{
                    Divider()
                    Spacer()
                }
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
            .padding()
            .contentShape(Rectangle())
            .BBToolBarTitle { }
        }
    }
}

