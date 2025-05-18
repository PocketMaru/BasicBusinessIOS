//
//  LPStatsView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import SwiftUI

struct StatsView: View {
    @Binding var customers: [CustomerModel]
    @Binding var businessStats: [BusinessStatsVM]
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
            .ToolBarTitle { }
        }
    }
}

