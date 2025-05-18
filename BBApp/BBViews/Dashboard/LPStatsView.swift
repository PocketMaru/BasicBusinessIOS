//
//  LPStatsView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import SwiftUI

struct BBStatsView: View {
    @Binding var customers: [BBCustomerModel]
    @Binding var businessStats: [BBBusinessStatsModel]
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
            .lpToolBarTitle { }
        }
    }
}

