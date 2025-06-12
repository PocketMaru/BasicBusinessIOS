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
            BusinessStatsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Business Stats")
                }
            CustomerView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Customers")
                }
            QuoteView()
                .tabItem {
                    Image(systemName: "quote")
                    Text("Quote")
                }
            ExpenseView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Expenses")
                }
            
        }
       
    }
}
