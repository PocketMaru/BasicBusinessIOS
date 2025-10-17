//
//  TabView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var customerListVM = CustomerListVM()
    @State private var quoteVM = QuoteVM(savedMaterials: MaterialModel.sampleList, draftQuote: QuoteModel.sample)
    @State private var materialVM = MaterialVM(materials: MaterialModel.sampleList)
    @State private var userVM = UserVM(user: UserModel.sample)
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
                    quoteVM: quoteVM,
                    customerListVM: customerListVM,
                    activeSheet: $activeSheet,
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
        /// Checks for changes to `activeSheet` records the old value and
        /// the new value, if the value is `.addCustomer` it creates the `addVM`.
        .onChange(of: activeSheet) { oldValue, newValue in
            switch newValue {
            case .addCustomer:
                addCustomerVM = customerListVM.addVM()
                
            case .addCustomerFromQuote:
                addCustomerVM = customerListVM.addVM(onSubmit: { customer in
                    try customerListVM.addCustomer(from: customer)
                    customerListVM.newCustomerFromQuote?(customer)
                    customerListVM.newCustomerFromQuote = nil
                    activeSheet = nil
                })
            default:
                break
            }
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .user:
                UserView(
                    userVM: userVM,
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    ), quoteVM: quoteVM
                )
            case .addCustomer:
                AddCustomerView(
                    customerListVM: customerListVM,
                    newCustomer: customerListVM.addVM(),
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    activeSheet: $activeSheet
                )
            case .addCustomerFromQuote:
                let vm = customerListVM.addVM(onSubmit: { customer in
                    try customerListVM.addCustomer(from: customer)
                    customerListVM.newCustomerFromQuote?(customer)
                    activeSheet = nil
                })
                
                AddCustomerView(
                    customerListVM: customerListVM,
                    newCustomer: vm,
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    activeSheet: $activeSheet
                )
            }
        }
    }
}

