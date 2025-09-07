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
    var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    @State private var showStatsSummary = true
    @State var selectedSummaryViewType: StatsSummaryViewType = .income
    var customerListVM: CustomerListVM
    @State private var showStatsDetailDestination = false
    @State private var hasAppeared: Bool = false
    private func handleStatTap(_ type: StatsSummaryViewType ) {
        selectedSummaryViewType = type
        if type == .invoices || type == .quotes || type == .income {
            showStatsSummary = true
            showStatsDetailDestination = false
        } else {
            showStatsSummary = false
            showStatsDetailDestination = true
        }
    }
    
    var invoiceVM = InvoiceVM(
        invoice: InvoiceModel.sampleList,
        customer: CustomerModel.sampleList
    )
    var expenseVM = ExpenseVM(
        expenses: ExpenseModel.sampleList
    )
    var quoteVM = QuoteVM(
        existingQuotes: QuoteModel.sampleList,
        savedMaterials: MaterialModel.sampleList,
        draftQuote: QuoteModel.sample
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
        ZStack(alignment: .top){
            AppColors.bg.ignoresSafeArea()
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 16) {
                        Color.clear
                            .frame(height: 1)
                            .id("top")
                        Spacer().frame(height: 375)
                        
                        if showStatsSummary {
                            Group {
                                if selectedSummaryViewType == .invoices {
                                    StatsSummaryView(
                                        selectedStat: $selectedSummaryViewType,
                                        invoiceVM: invoiceVM,
                                        expenseVM: expenseVM,
                                        quoteVM: quoteVM, materialVM: materialVM,
                                        businessStatsVM: businessStatsVM,
                                        customerListVM: customerListVM,
                                        activeSheet: $activeSheet
                                    )
                                } else if selectedSummaryViewType == .quotes {
                                    StatsSummaryView(
                                        selectedStat: $selectedSummaryViewType,
                                        invoiceVM: invoiceVM,
                                        expenseVM: expenseVM,
                                        quoteVM: quoteVM, materialVM: materialVM,
                                        businessStatsVM: businessStatsVM,
                                        customerListVM: customerListVM,
                                        activeSheet: $activeSheet
                                    )
                                } else if selectedSummaryViewType == .income {
                                    StatsSummaryView(
                                        selectedStat: $selectedSummaryViewType,
                                        invoiceVM: invoiceVM,
                                        expenseVM: expenseVM,
                                        quoteVM: quoteVM, materialVM: materialVM,
                                        businessStatsVM: businessStatsVM,
                                        customerListVM: customerListVM,
                                        activeSheet: $activeSheet
                                    )
                                }
                            }
                                .id(selectedSummaryViewType)
                                .padding(.horizontal)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .animation(.easeInOut, value: selectedSummaryViewType)
                                .onAppear {
                                    if !hasAppeared {
                                        hasAppeared = true
                                        if selectedSummaryViewType == .invoices || selectedSummaryViewType == .quotes || selectedSummaryViewType == .income {
                                                    showStatsSummary = true
                                                }
                                    }
                                    
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 32)
                }
                .scrollIndicators(.hidden)
                .onChange(of: selectedSummaryViewType) {
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
                }
            }
            
            VStack(alignment: .center, spacing: 25) {
                Spacer().frame(height: 5)
                LargeStatButtonView(
                    titleOne: "Invoices",
                    valueOne: Double(invoiceVM.invoice.count),
                    titleTwo: "Income",
                    valueTwo: businessStatsVM.totalProfit,
                    titleThree: "Quotes",
                    valueThree: Double(quoteVM.quotes.count),
                    tapActionOne: {
                        handleStatTap(.invoices)
                    }, tapActionTwo: {
                        handleStatTap(.income)
                    }, tapActionThree: {
                        handleStatTap(.quotes)
                    })
                
                HStack(spacing: 30) {
                    StatButtonView(label: "Status",
                                   value: Double(customerListVM.allCustomers.count),
                                   tapAction: {
                        handleStatTap(.customers)
                    })

                    StatButtonView(label: "Materials",
                                   value: Double(materialVM.materials.count),
                                   tapAction: {
                        handleStatTap(.materials)
                    })

                }
                if selectedSummaryViewType.title == "Invoices" {
                    Text("\(selectedSummaryViewType.title)")
                        .bubbleStyle()
                        .statButtonBG()

                } else if selectedSummaryViewType.title == "Quotes" {
                    Text("\(selectedSummaryViewType.title)")
                        .bubbleStyle()
                        .statButtonBG()
                } else if selectedSummaryViewType.title == "Income Details"{
                    Text("\(selectedSummaryViewType.title)")
                        .bubbleStyle()
                        .statButtonBG()
                } else {
                    Text("Select a Summary")
                        .bubbleStyle()
                        .statButtonBG()
                }
            }
            .padding(.horizontal)
            .background(AppColors.bg)
            .zIndex(1)
        }
        .ToolBarTitle(
            title: userVM.user.businessName,
            mainIconTapped: {
                activeSheet = .user
            })
        .navigationDestination(isPresented: $showStatsDetailDestination) {
            StatsSummaryView(
                selectedStat: $selectedSummaryViewType,
                invoiceVM: invoiceVM,
                expenseVM: expenseVM,
                quoteVM: quoteVM,
                materialVM: materialVM,
                businessStatsVM: businessStatsVM,
                customerListVM: customerListVM,
                activeSheet: $activeSheet
            )
        }
    }
}
