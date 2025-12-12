import SwiftUI

enum StatDetailSheetItem: Identifiable {
    case invoice(InvoiceModel)
    case expense(ExpenseModel)
    case income(InvoiceModel)
    case quote(QuoteModel)
    case customer(CustomerModel)
    case material(MaterialModel)
    
    var id: UUID {
        switch self {
        case .invoice(let invoice): return invoice.id
        case .expense(let expense): return expense.id
        case .income(let invoice): return invoice.id
        case .quote(let quote): return quote.id
        case .customer(let customer): return customer.id
        case .material(let material): return material.id
        }
    }
    
    var statType: StatsSummaryViewType {
        switch self {
        case .invoice: return .invoices
        case .expense: return .expenses
        case .income: return .invoices
        case .quote: return .quotes
        case .customer: return .customers
        case .material: return .materials
        }
    }
}
@MainActor
struct StatsSummaryView: View {
    @Binding var selectedStat: StatsSummaryViewType
    var invoiceListVM: InvoiceListVM
    var expenseListVM: ExpenseListVM
    var quoteListVM: QuoteListVM
    var materialListVM: MaterialListVM
    var businessStatsVM: BusinessStatsVM
    var customerListVM: CustomerListVM
    @State private var statDetailSheetItem: StatDetailSheetItem?
    @State private var paidStatus: Bool = true
    @State private var navigateToCustomerDetail: CustomerModel? = nil
    @Binding var activeSheet: ActiveUserSheet?
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        if selectedStat == .invoices {
                            ForEach(invoiceListVM.allInvoices) { invoice in
                                if let customer = customerListVM.getCustomer(for: invoice.customerID) {
                                    CustomSectionView(
                                        headerTitle: customer.fullName ?? customer.firstName
                                    ) {
                                        VStack {
                                            Text(customer.phone)
                                            Divider()
                                            Text(String(invoice.invoiceDate.formatted(date: .abbreviated, time: .omitted)))
                                            
                                            Divider()
                                            Text(String(invoice.totalCost))
                                            
                                            Spacer()
                                        }
                                    } tapped: {
                                        statDetailSheetItem = .invoice(invoice)
                                    }
                                    .statBubbleStyle()
                                    .statButtonBG()
                                }
                            }
                        } else if selectedStat == .expenses {
                            ForEach(expenseListVM.allExpenses) { expense in
                                CustomSectionView(
                                    headerTitle: expense.name
                                ) {
                                    VStack {
                                        Text(String(expense.date.formatted(date: .abbreviated, time: .omitted)))
                                        Divider()
                                        Text(expense.type.name)
                                        Divider()
                                        Text(String(expense.calcTotal))
                                    }
                                } tapped: {
                                    statDetailSheetItem = .expense(expense)
                                }
                            }
                        } else if selectedStat == .income {
                            CustomMultiForm(
                                titleOne: "Revenue",
                                valueOne: "\(businessStatsVM.invoicedRevenue)",
                                titleTwo: "Expenses",
                                valueTwo: "\(businessStatsVM.confirmedExpenses)",
                                titleThree: "Forecasted Revenue",
                                valueThree: "\(businessStatsVM.forecastedProfit)",
                                titleFour: "Forecasted Expenses",
                                valueFour: "\(businessStatsVM.forecastedExpenses)",
                                titleFive: nil,
                                valueFive: nil,
                                titleSix: nil,
                                valueSix: nil,
                                titleSeven: nil,
                                valueSeven: nil,
                                titleEight: nil,
                                valueEight: nil
                            )
                            .statButtonBG()
                        } else if selectedStat == .quotes {
                            ForEach(quoteListVM.allQuotes) { quote in
                                if let customer = customerListVM.getCustomer(for: quote.customerID) {
                                    CustomSectionView(
                                        headerTitle: customer.fullName ?? customer.firstName
                                    ) {
                                        VStack {
                                            Text(customer.phone)
                                            Divider()
                                            Text(String(quote.quoteDate.formatted(date: .abbreviated, time: .omitted)))
                                            Divider()
                                            Text(String(quote.totalCost))
                                            Spacer()
                                        }
                                    } tapped: {
                                        statDetailSheetItem = .quote(quote)
                                    }
                                    .statBubbleStyle()
                                    .statButtonBG()
                                }
                            }
                        } else if selectedStat == .materials {
                            ForEach(materialListVM.allMaterials) { material in
                                CustomSectionView(
                                    headerTitle: material.name
                                ) {
                                    VStack {
                                        Text("\(material.unitCost)")
                                        Divider()
                                        Text(material.unitType.displayName)
                                        Divider()
                                        Text(material.description ?? "")
                                        Spacer()
                                    }
                                } tapped: {
                                    statDetailSheetItem = .material(material)
                                }
                                .statBubbleStyle()
                                .statButtonBG()
                            }
                        } else if selectedStat == .customers {
                            VStack (spacing: 10) {
                                if paidStatus {
                                    ForEach(customerListVM.paidCustomers, id: \.id) { customer in
                                        NavigationLink(destination: CustomerDetailView(
                                            customer: customerListVM.editVM(for: customer),
                                            listVM: customerListVM,
                                            activeSheet: $activeSheet
                                        )
                                        ) {
                                            CustomSectionView(
                                                headerTitle: customer.fullName ?? customer.firstName
                                            ) {
                                                VStack {
                                                    Text(customer.phone)
                                                    Divider()
                                                    Text(customer.address ?? "No Address Available")
                                                    Divider()
                                                    Text(customer.paidBill == true ? "Paid" : "Unpaid").foregroundStyle( AppColors.accent)
                                                }
                                            }
                                            .statBubbleStyle()
                                            .statButtonBG()
                                        }
                                        
                                    }
                                } else {
                                    ForEach(customerListVM.unpaidCustomers, id: \.id) { customer in
                                        NavigationLink(destination: CustomerDetailView(
                                            customer: customerListVM.editVM(for: customer),
                                            listVM: customerListVM,
                                            activeSheet: $activeSheet
                                        )) {
                                            CustomSectionView(
                                                headerTitle: customer.fullName ?? customer.firstName
                                            ) {
                                                VStack {
                                                    Text(customer.phone)
                                                    Divider()
                                                    Text(customer.address ?? "No Address Available")
                                                    Divider()
                                                    Text(customer.paidBill == false ? "unPaid" : "Paid").foregroundStyle( AppColors.accent)
                                                }
                                            }
                                            .statBubbleStyle()
                                            .statButtonBG()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .ToolBarTitle(
                title: selectedStat.title,
                iconName: nil,
                mainIconTapped: nil
            )
            .safeAreaInset(edge: .top) {
                if selectedStat == .customers {
                    HStack (spacing: 10){
                        StatButtonView(
                            label: "Paid",
                            value: Double(customerListVM.paidCustomers.count),
                            tapAction: {
                            paidStatus = true
                        })
                        StatButtonView(
                            label: "Unpaid",
                            value: Double(customerListVM.unpaidCustomers.count),
                            tapAction: {
                            paidStatus = false
                        })
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
