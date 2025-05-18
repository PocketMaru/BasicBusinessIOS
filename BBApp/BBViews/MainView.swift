//
//  ContentView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/4/25.
//

import SwiftUI

struct TabView: View {
    @State var customers = [LPCustomerModel()]
    @State var businessStats = [LPBusinessStatsModel()]
    var body: some View {
        HStack {
            TabView {
                LPCustomerView(customers: $customers, businessStats: $businessStats)
                .tabItem {
                    Label("Clients", systemImage: "house")
                        
                }
                LPQuoteView(customers: $customers, businessStats: $businessStats)
                .tabItem {
                    Label("Quotes", systemImage: "note.text")
                }
                LPStatsView(customers: $customers, businessStats: $businessStats)
                .tabItem {
                    Label("Stats", systemImage: "dollarsign.ring")
                }
            }
        }
    }
}

