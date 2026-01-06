import SwiftUI

enum AppTab: Hashable {
    case stats
    case customers
    case documents
    case expenses
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .stats
    @State private var appFeature = AppFeature()
    @State private var activeSheet: ActiveUserSheet?
    #warning("Refactor this after you finish the DocumentsFeature")
    #warning("Remove sheet navigation for adding a customer")
    #warning("Replace with a new view")
    @State private var addCustomerVM: CustomerFormVM? = nil
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "Business Stats",
                systemImage: "chart.bar",
                value: .stats
            ) {
                NavigationStack {
                    BusinessStatsView(
                        journalFeature: appFeature.journalFeature,
                        activeSheet: $activeSheet
                    )
                }
            }
            
            Tab (
                "Customers",
                systemImage: "person.3",
                value: .customers
            ) {
                NavigationStack {
                    CustomerListView(
                        customerListVM: appFeature.customerListVM,
                        userVM: appFeature.userVM,
                        activeSheet: $activeSheet
                    )
                }
            }
            
            Tab(
                "Documents",
                systemImage: "book.pages",
                value: .documents
            ) {
                NavigationStack {
                    JobDocumentListView(
                        userVM: appFeature.userVM,
                        jobDocRouter: appFeature.jobDocRouterFeature,
                        activeSheet: $activeSheet
                    )
                }
            }
            
            Tab(
                "Expenses",
                systemImage: "dollarsign.circle.fill",
                value: .expenses
            ) {
                NavigationStack {
                    ExpenseView(
                        userVM: appFeature.userVM,
                        activeSheet: $activeSheet
                    )
                }
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

