//
//  ExpenseView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct ExpenseView: View {
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Expense View")
                        .padding()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .ToolBarTitle(title: userVM.user?.businessName ?? "", mainIconTapped: {
            activeSheet = .user
        })
    }
    
}
