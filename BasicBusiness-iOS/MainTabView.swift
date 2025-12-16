import SwiftUI

struct MainTabView: View {
    @State private var userVM: UserVM
    @State private var customerListVM: CustomerListVM
    @State private var materialListVM: MaterialListVM
    @State private var quoteListVM: QuoteListVM
    @State private var invoiceListVM: InvoiceListVM
    @State private var expenseListVM: ExpenseListVM
    @State private var businessStatsVM: BusinessStatsVM
    @State private var jobDocRouterVM: JobDocumentRouterVM
    
    @State private var activeSheet: ActiveUserSheet?
    @State private var addCustomerVM: CustomerFormVM? = nil
    
    
    init() {

        let fileStorageManager = FileStorageManager()
        let loader = AppLoader(storage: fileStorageManager)
        // app loader calls
        let customers: [CustomerModel]
        let quotes: [QuoteModel]
        let invoices: [InvoiceModel]
        
        #if DEBUG
        customers = CustomerModel.mockList
        quotes = customers.compactMap { customer in
            QuoteModel.mock(customerID: customer.id)
        }
        
        invoices = customers.map {
            InvoiceModel.mock(customerID: $0.id)
        }
        #else
        customers = loader.load(for: .customers) ?? []
        quotes = loader.load(for: .quotes) ?? []
        invoices = loader.load(for: .invoices) ?? []
        #endif
        
        let saveCustomerUseCase = SaveCustomer(fileStorage: fileStorageManager)
        let saveQuoteUseCase = SaveQuote(fileStorage: fileStorageManager)
        let saveInvoiceUseCase = SaveInvoice(fileStorage: fileStorageManager)
        
        let userVM = UserVM(user: UserModel.sample)
        let customerListVM = CustomerListVM(initialCustomers: customers, saveCustomer: saveCustomerUseCase )
        let materialListVM = MaterialListVM()
        let quoteListVM = QuoteListVM(
            initialQuotes: quotes,
            customerListVM: customerListVM,
            materialCatalogVM: materialListVM,
            saveQuoteUseCase: saveQuoteUseCase
        )
        let invoiceListVM = InvoiceListVM(
            initialInvoices: invoices,
            customerListVM: customerListVM,
            materialCatalogVM: materialListVM,
            saveInvoice: saveInvoiceUseCase
        )
        let expenseListVM = ExpenseListVM()
        let businessStatsVM = BusinessStatsVM(
            quoteData: quoteListVM,
            expenseData: expenseListVM,
            invoiceData: invoiceListVM
        )
        let jobDocRouterVM = JobDocumentRouterVM(
            customerListVM: customerListVM,
            quoteListVM: quoteListVM,
            invoiceListVM: invoiceListVM,
            savedMaterials: materialListVM.allMaterials,
            saveQuoteUseCase: saveQuoteUseCase,
            saveInvoiceUseCase: saveInvoiceUseCase
        )
        _userVM = State(initialValue: userVM)
        _customerListVM = State(initialValue: customerListVM)
        _materialListVM = State(initialValue: materialListVM)
        _quoteListVM = State(initialValue: quoteListVM)
        _invoiceListVM = State(initialValue: invoiceListVM)
        _expenseListVM = State(initialValue: expenseListVM)
        _businessStatsVM = State(initialValue: businessStatsVM)
        _jobDocRouterVM = State(initialValue: jobDocRouterVM)
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
                JobDocumentListView(userVM: userVM, jobDocRouter: jobDocRouterVM, activeSheet: $activeSheet)
            }
            .tabItem {
                Image(systemName: "book.pages")
                Text("Documents")
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

