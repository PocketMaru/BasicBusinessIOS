//
//  QuoteView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct QuoteView: View {
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Quote View")
                        .padding()
                }
                .frame(maxWidth: .infinity)
            }
        }
       
        .ToolBarTitle()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}
