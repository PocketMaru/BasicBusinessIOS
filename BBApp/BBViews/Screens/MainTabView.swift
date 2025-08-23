//
//  TabView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct MainTabView: View {
    var customerListVM: CustomerListVM
    var quoteVM: QuoteVM
    var materialVM: MaterialVM
    var userVM = UserVM(user: UserModel.sample)
    @State private var activeSheet: ActiveUserSheet?
    @State private var addCustomerVM: CustomerFormVM? = nil
    
    var body: some View {
        
        TabView {
            NavigationStack {
                BusinessStatsView(
                    userVM: userVM,
                    activeSheet: $activeSheet,
                    customerListVM: customerListVM
                )
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Business Stats")
            }
            
            NavigationStack {
                CustomerListView(
                    customerListVM: customerListVM,
                    createAddCustomerVM: {
                        addCustomerVM = customerListVM.addVM()
                    },
                    userVM: userVM,
                    activeSheet: $activeSheet
                    
                )
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Customers")
            }
            
            NavigationStack {
                QuoteView(
                    userVM: userVM,
                    activeSheet: $activeSheet
                )
            }
            .tabItem {
                Image(systemName: "book.pages")
                Text("Quote")
            }
            
            NavigationStack {
                ExpenseView(
                    userVM: userVM,
                    activeSheet: $activeSheet
                )
            }
            .tabItem {
                Image(systemName: "dollarsign.circle.fill")
                Text("Expenses")
            }
        }
        .tabViewStyle(DefaultTabViewStyle())
        .tint(.primaryAccent)
        .sheet(item: $activeSheet) { item in
            switch item {
            case .user:
                UserView(
                    userVM: userVM,
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    )
                )
            case .addCustomer:
                if let vm = addCustomerVM {
                    AddCustomerView(
                        customerListVM: customerListVM,
                        newCustomer: vm,
                        isPresented: Binding(
                            get: {activeSheet != nil},
                            set: {if !$0 {activeSheet = nil}}
                        ),
                        activeSheet: $activeSheet
                    )
                } else {
                    EmptyView()
                }
            }
        }
    }
}

