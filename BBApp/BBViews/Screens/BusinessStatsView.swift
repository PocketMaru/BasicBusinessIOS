//
//  BusinessStatsView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

enum StatsSummaryViewType {
    case income
    case expenses
    case quotes
    case invoices
    case profitForecast
    case expensesForecast
    case customers
    case materials
    
    var title: String {
        switch self {
        case .income:
            return "Income Details"
        case .expenses:
            return "Expenses"
        case .quotes:
            return "Quotes"
        case .invoices:
            return "Invoices"
        case .profitForecast:
            return "Profit Forecast"
        case .expensesForecast:
            return "Expenses Forecast"
        case .customers:
            return "Customers"
        case .materials:
            return "Materials"
        }
    }
}

struct BusinessStatsView: View {
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    
    @State private var showStatsSummary = false
    @State var selectedSummaryViewType: StatsSummaryViewType = .income
    
    var customerListVM = CustomerListVM(
        customers: CustomerModel.sampleList
    )
    
    var invoiceVM = InvoiceVM(
        invoice: InvoiceModel.sampleList,
        customer: CustomerModel.sampleList
    )
    var expenseVM = ExpenseVM(
        expenses: ExpenseModel.sampleList
    )
    var quoteVM = QuoteVM(
        existingQuotes: QuoteModel.sampleList,
        savedMaterials: MaterialModel.sampleList
    )
    var businessStatsVM = BusinessStatsVM(
        quoteData: QuoteModel.sampleList,
        expenseData: ExpenseModel.sampleList,
        invoiceData: InvoiceModel.sampleList
    )
    var materialVM = MaterialVM(
        materials: MaterialModel.sampleList
    )
    var body: some View {
            ZStack{
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        LargeStatButtonView(
                            titleOne: "Customers",
                            valueOne: Double(customerListVM.allCustomers.count),
                            titleTwo: "Profit",
                            valueTwo: businessStatsVM.totalProfit,
                            titleThree: "Materials",
                            valueThree: Double(materialVM.materials.count),
                            tapActionOne: {
                                selectedSummaryViewType = .customers
                                showStatsSummary = true
                            }, tapActionTwo: {
                                selectedSummaryViewType = .income
                                showStatsSummary = true
                            }, tapActionThree: {
                                selectedSummaryViewType = .materials
                                showStatsSummary = true
                            })
                        HStack(spacing: 10) {
                            StatButtonView(label: "Invoices",
                                           value: Double(invoiceVM.invoice.count),
                                           tapAction: {
                                selectedSummaryViewType = .invoices
                                showStatsSummary = true
                            })
                            
                            StatButtonView(label: "Quotes",
                                           value: Double(quoteVM.quotes.count),
                                           tapAction: {
                                selectedSummaryViewType = .quotes
                                showStatsSummary = true
                            })
                        }
                            HStack(spacing: 10) {
                                StatButtonView(
                                    label: "Expenses",
                                    value: expenseVM.expenses.reduce(0) {$0 + ($1.total)},
                                    tapAction: {
                                    selectedSummaryViewType = .expenses
                                    showStatsSummary = true
                                } )
                                
                                StatButtonView(
                                    label: "Forecasted \n Expenses",
                                    value: businessStatsVM.forecastedExpenses,
                                    tapAction: {
                                    selectedSummaryViewType = .expensesForecast
                                    showStatsSummary = true
                                } )
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .ToolBarTitle(title: userVM.user.businessName, mainIconTapped: {
                activeSheet = .user
            })
            
            .navigationDestination(isPresented: $showStatsSummary) {
                StatsSummaryView(
                    selectedStat: $selectedSummaryViewType,
                    invoiceVM: invoiceVM,
                    expenseVM: expenseVM,
                    quoteVM: quoteVM,
                    businessStatsVM: businessStatsVM,
                    customerListVM: customerListVM,
                    activeSheet: $activeSheet
                )
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

