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
    
    var body: some View {
        
        TabView {
            NavigationStack {
                BusinessStatsView()
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Business Stats")
            }
            
            NavigationStack {
                CustomerView(customerListVM: customerListVM, customerDetailVM: customerDetailVM)
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Customers")
            }
            
            NavigationStack {
                QuoteView()
            }
            .tabItem {
                Image(systemName: "book.pages")
                Text("Quote")
            }
            
            NavigationStack {
                ExpenseView()
            }
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Expenses")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .tint(.primaryAccent)
        
    }
}

