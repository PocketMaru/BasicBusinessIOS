//
//  StatsSummaryView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

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

struct StatsSummaryView: View {
    @Binding var selectedStat: StatsSummaryViewType
    var invoiceVM: InvoiceVM
    var expenseVM: ExpenseVM
    var quoteVM: QuoteVM
    var materialVM: MaterialVM
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
                                ForEach(invoiceVM.invoice.indices, id: \.self) { index in
                                    let invoice = invoiceVM.invoice[index]
                                    CustomSectionView(
                                        headerTitle: invoice.customer.fullName ?? invoice.customer.firstName
                                    ) {
                                        VStack {
                                            Text(invoice.customer.phone)
                                            Divider()
                                            Text(String(invoice.invoiceDate.formatted(date: .abbreviated, time: .omitted)))
                                            
                                            Divider()
                                            Text(String(invoice.totalCost ?? 0))
                                            
                                            Spacer()
                                        }
                                    } tapped: {
                                        statDetailSheetItem = .invoice(invoice)
                                    }
                                    .statBubbleStyle()
                                    .statButtonBG()
                                }
                        } else if selectedStat == .expenses {
                            ForEach(expenseVM.expenses.indices, id: \.self) { index in
                                let expense = expenseVM.expenses[index]
                                CustomSectionView(
                                    headerTitle: expense.name
                                ) {
                                    VStack {
                                        Text(String(expense.date.formatted(date: .abbreviated, time: .omitted)))
                                        Divider()
                                        Text(expense.type.name)
                                        Divider()
                                        Text(String(expense.total))
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
                            ForEach(quoteVM.quotes.indices, id: \.self) { index in
                                let quoteItem = quoteVM.quotes[index]
                                CustomSectionView(
                                    headerTitle: quoteItem.customer.fullName ?? quoteItem.customer.firstName
                                ) {
                                    VStack {
                                        Text(quoteItem.customer.phone)
                                        Divider()
                                        Text(String(quoteItem.quoteDate.formatted(date: .abbreviated, time: .omitted)))
                                        Divider()
                                        Text(String(quoteItem.totalCost ?? 0))
                                        Spacer()
                                    }
                                } tapped: {
                                    statDetailSheetItem = .quote(quoteItem)
                                }
                                .statBubbleStyle()
                                .statButtonBG()
                            }
                        } else if selectedStat == .materials {
                            ForEach(materialVM.materials.indices, id: \.self) { index in
                                let materialItem = materialVM.materials[index]
                                CustomSectionView(
                                    headerTitle: materialItem.name
                                ) {
                                    VStack {
                                        Text("\(materialItem.unitCost)")
                                        Divider()
                                        Text(materialItem.unitType.displayName)
                                        Divider()
                                        Text(materialItem.description ?? "")
                                        Spacer()
                                    }
                                } tapped: {
                                    statDetailSheetItem = .material(materialItem)
                                }
                                .statBubbleStyle()
                                .statButtonBG()
                            }
                        } else if selectedStat == .customers {
                            VStack (spacing: 10) {
                                if paidStatus {
                                    ForEach(customerListVM.paidCustomers, id: \.id) { customer in
                                        NavigationLink(destination: CustomerDetailView(
                                            customer: configuredDetailVM(for: customer),
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
                                            customer: configuredDetailVM(for: customer),
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
    private func configuredDetailVM(for customer: CustomerModel) -> CustomerFormVM {
        let useCase = SaveCustomerInteractor(fileStorage: FileStorageManager())
        let customerDetail = CustomerFormVM(
            customer: customer, mode: .edit,
            saveUseCase: useCase
        )
        return customerDetail
    }
}
