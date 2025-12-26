import SwiftUI

struct MainTabView: View {
    
    @State private var appFeature = AppFeature()
    @State private var activeSheet: ActiveUserSheet?
    #warning("Refactor this after you finish the DocumentsFeature")
    #warning("Remove sheet navigation for adding a customer")
    #warning("Replace with a new view")
    @State private var addCustomerVM: CustomerFormVM? = nil
    
    var body: some View {
        TabView {
            NavigationStack {
                BusinessStatsView(
                    journalFeature: appFeature.journalFeature,
                    activeSheet: $activeSheet
                )
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("Business Stats")
            }
            NavigationStack {
                CustomerListView(
                    customerListVM: appFeature.customerListVM,
                    userVM: appFeature.userVM,
                    activeSheet: $activeSheet
                )
            }
            .tabItem {
                Image(systemName: "person.3")
                Text("Customers")
            }
            NavigationStack {
                JobDocumentListView(
                    userVM: appFeature.userVM,
                    jobDocRouter: appFeature.jobDocRouterFeature,
                    activeSheet: $activeSheet
                )
            }
            .tabItem {
                Image(systemName: "book.pages")
                Text("Documents")
            }
            NavigationStack {
                ExpenseView(
                    userVM: appFeature.userVM,
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
        .onChange(of: activeSheet) { oldValue, newValue in
            switch newValue {
            case .addCustomer:
                addCustomerVM = appFeature.customerListVM.addVM()
                
            case .addCustomerFromQuote:
                addCustomerVM = appFeature.customerListVM.addVM(onSubmit: { customer in
                    try appFeature.customerListVM.addCustomer(from: customer)
                    appFeature.customerListVM.newCustomerFromQuote?(customer)
                    appFeature.customerListVM.newCustomerFromQuote = nil
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
                    userVM: appFeature.userVM,
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    quoteListVM: appFeature.quoteListVM
                )
            case .addCustomer:
                AddCustomerView(
                    customerListVM: appFeature.customerListVM,
                    newCustomer: appFeature.customerListVM.addVM(),
                    isPresented: Binding(
                        get: { activeSheet != nil },
                        set: { if !$0 { activeSheet = nil } }
                    ),
                    activeSheet: $activeSheet
                )
            case .addCustomerFromQuote:
                let vm = appFeature.customerListVM.addVM(onSubmit: { customer in
                    try appFeature.customerListVM.addCustomer(from: customer)
                    appFeature.customerListVM.newCustomerFromQuote?(customer)
                    activeSheet = nil
                })
                
                AddCustomerView(
                    customerListVM: appFeature.customerListVM,
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

