//
//  LPCustomTabView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/10/25.
//

import SwiftUI

struct BBCustomTabView: View {
    enum Tab { case customer, quotes, business, expenses}
    @State var customers: [BBCustomerModel] = []
    @State var businessStats: [BBBusinessStatsModel] = []
    @State private var selectedTab: Tab = .customer
    var body: some View {
        ZStack {
            switch selectedTab {
            case .customer:
                NavigationLink(destination: BBCustomerView(customers: $customers, businessStats: $businessStats)) {}
            case .quotes:
                NavigationLink(destination: BBQuoteView(customers: $customers, businessStats: $businessStats)) {}
            case .business:
                NavigationLink(destination: BBStatsView(customers: $customers, businessStats: $businessStats)) {}
            case .expenses:
                BBExpensesView()
            }
            HStack(alignment: .center) {
                
                Button {
                    //CustomerView
                    selectedTab = .customer
                } label: {
                    
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: selectedTab == .customer ? "house.fill" : "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(BBColor.logoColor)
                        Text("Clients")
                            .foregroundStyle(BBColor.logoColor)
                    }
                    
                }
                Button {
                    //CustomerView
                    selectedTab = .customer
                } label: {
                    
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: selectedTab == .customer ? "house.fill" : "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(BBColor.logoColor)
                        Text("Clients")
                            .foregroundStyle(BBColor.logoColor)
                    }
                }
                Button {
                    //CustomerView
                    selectedTab = .customer
                } label: {
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: selectedTab == .customer ? "house.fill" : "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(BBColor.logoColor)
                        Text("Clients")
                            .foregroundStyle(BBColor.logoColor)
                    }
                }
                Button {
                    //CustomerView
                    selectedTab = .customer
                } label: {
                    
                    VStack(alignment: .center, spacing: 4) {
                        Image(systemName: selectedTab == .customer ? "house.fill" : "house")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(BBColor.logoColor)
                        Text("Clients")
                            .foregroundStyle(BBColor.logoColor)
                    }
                }
                
            }
            
        }
        
    }
    func tabButton(icon: String, title: String, tab: Tab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack {
                Image(systemName: selectedTab == tab ? "\(icon).fill" : icon)
                Text(title)
            }
            .foregroundStyle(selectedTab == tab ? BBColor.logoColor : .gray)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    BBCustomTabView()
}
