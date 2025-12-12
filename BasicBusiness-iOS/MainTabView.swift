import SwiftUI

struct MainTabView: View {
    @State private var userVM: UserVM
    @State private var customerListVM: CustomerListVM
    @State private var materialListVM: MaterialListVM
    @State private var quoteListVM: QuoteListVM
    @State private var invoiceListVM: InvoiceListVM
    @State private var expenseListVM: ExpenseListVM
    @State private var businessStatsVM: BusinessStatsVM
    
    @State private var activeSheet: ActiveUserSheet?
    @State private var addCustomerVM: CustomerFormVM? = nil
    
    init() {
        let userVM = UserVM(user: UserModel.sample)
        let customerListVM = CustomerListVM()
        let materialListVM = MaterialListVM()
        let quoteListVM = QuoteListVM(
            customerListVM: customerListVM,
            materialCatalogVM: materialListVM
        )
        let invoiceListVM = InvoiceListVM(
            customerListVM: customerListVM,
            materialCatalogVM: materialListVM
        )
        let expenseListVM = ExpenseListVM()
        let businessStatsVM = BusinessStatsVM(
            quoteData: quoteListVM,
            expenseData: expenseListVM,
            invoiceData: invoiceListVM
        )
        _userVM = State(initialValue: userVM)
        _customerListVM = State(initialValue: customerListVM)
        _materialListVM = State(initialValue: materialListVM)
        _quoteListVM = State(initialValue: quoteListVM)
        _invoiceListVM = State(initialValue: invoiceListVM)
        _expenseListVM = State(initialValue: expenseListVM)
        _businessStatsVM = State(initialValue: businessStatsVM)
    }
    
    var body: some View {
        
        TabView {
            NavigationStack {
                BusinessStatsView(
                    userVM: userVM,
                    customerListVM: customerListVM,
                    materialListVM: materialListVM,
                    quoteListVM: quoteListVM,
                    invoiceListVM: invoiceListVM,
                    expenseListVM: expenseListVM,
                    businessStatsVM: businessStatsVM,
                    activeSheet: $activeSheet
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
                JobDocumentFormView(
                    userVM: userVM,
                    customerListVM: customerListVM,
                    quoteListVM: quoteListVM,
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
                    ),
                    quoteListVM: quoteListVM
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

