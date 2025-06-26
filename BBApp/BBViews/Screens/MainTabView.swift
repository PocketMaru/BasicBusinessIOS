//
//  TabView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct MainTabView: View {
    var customerListVM: CustomerListVM
    var customerDetailVM: CustomerDetailVM
    var quoteVM: QuoteVM
    var materialVM: MaterialVM
    var userVM = UserVM(user: UserModel.sample)
    @State private var activeSheet: ActiveUserSheet?
    
    
    var body: some View {
        
        TabView {
            NavigationStack {
                BusinessStatsView(userVM: userVM, activeSheet: $activeSheet)
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Business Stats")
            }
            
            NavigationStack {
                CustomerView(customerListVM: customerListVM, userVM: userVM, activeSheet: $activeSheet )
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Customers")
            }
            
            NavigationStack {
                QuoteView(userVM: userVM, activeSheet: $activeSheet)
            }
            .tabItem {
                Image(systemName: "book.pages")
                Text("Quote")
            }
            
            NavigationStack {
                ExpenseView(userVM: userVM, activeSheet: $activeSheet)
            }
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Expenses")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .tint(.primaryAccent)
        .sheet(item: $activeSheet) { item in
            if case .user = item {
                UserView(
                    userVM: userVM,
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            }
        }
    }
}

