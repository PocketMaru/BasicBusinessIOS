//
//  QuoteView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

enum QuoteFields {
    case isActive
    case isInactive
    case isNotAssigned
}

struct QuoteView: View {
    @Bindable var userVM: UserVM
    @Bindable var quoteVM: QuoteVM
    @Bindable var customerListVM: CustomerListVM
    @Binding var activeSheet: ActiveUserSheet?
    @State private var editQuoteFields: Bool = false
    @State private var QuoteFields: QuoteFields = .isNotAssigned
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            
        }
        .ToolBarTitle(
            title: userVM.user.businessName,
            editIconName: "plusminus.circle",
            editButtonColor: activeSheet == nil ? AppColors.accent : AppColors.success,
            mainIconTapped: {
                if activeSheet == nil {
                    activeSheet = .user
                }
        }, editIconTapped: {
            editQuoteFields = true
        })
    }
}
