//
//  ContentView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/4/25.
//

import SwiftUI

struct MainTabView: View {
    @State var customers: [BBCustomerModel] = []
    @State var businessStats: [BBBusinessStatsModel] = []
    
    var body: some View {
        HStack {
            TabView() {
                BBCustomerView(customers: $customers, businessStats: $businessStats)
                    .tabItem {
                        Label("Clients", systemImage: "house.fill")
                    }
                BBQuoteView(customers: $customers, businessStats: $businessStats)
                    .tabItem {
                        Label("Quotes", systemImage: "note.text")
                    }
                BBStatsView(customers: $customers, businessStats: $businessStats)
                    .tabItem {
                        Label("Stats", systemImage: "dollarsign.ring")
                    }
                BBExpensesView()
                    .tabItem {
                        Label("Expenses", systemImage: "cart.fill")
                    }
            }
        }
    }
}

