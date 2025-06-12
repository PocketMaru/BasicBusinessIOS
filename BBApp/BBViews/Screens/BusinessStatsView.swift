//
//  BusinessStatsView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct BusinessStatsView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                        VStack {
                            Text("Stats View")
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .ToolBarTitle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

