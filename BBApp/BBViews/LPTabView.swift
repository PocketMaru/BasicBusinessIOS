//
//  ContentView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/4/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        HStack {
            TabView {
                LPCustomerView()
                .tabItem {
                    Label("Clients", systemImage: "house")
                        
                }
                LPQuoteView()
                .tabItem {
                    Label("Quotes", systemImage: "note.text")
                }
                LPStatsView()
                .tabItem {
                    Label("Stats", systemImage: "dollarsign.ring")
                }
            }
        }
    }
}

