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
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expenses:
            return "Expenses"
        case .quotes:
            return "Quotes"
        case .invoices:
            return "Invoices"
        }
    }
}

struct BusinessStatsView: View {
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    
    @State private var showStatsSummary = false
    @State var selectedSummaryViewType: StatsSummaryViewType = .income
    
    var invoices = InvoiceVM(invoice: InvoiceModel.sampleList, customer: CustomerModel.sampleList)
    var expenses = ExpenseVM(expenses: ExpenseModel.sampleList )
    
    var body: some View {
            ZStack{
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                        VStack {
                            HStack(spacing: 16) {
                                StatButtonView(label: "Total Income", value: "1000", tapAction: {
                                    selectedSummaryViewType = .income
                                    showStatsSummary = true
                                } )
                                    .padding()
                                StatButtonView(label: "Total Expenses", value: "1000", tapAction: {
                                    selectedSummaryViewType = .expenses
                                    showStatsSummary = true
                                } )
                                    .padding()
                            }
                            
                            HStack {
                                StatButtonView(label: "Quotes", value: "1000", tapAction: {
                                    selectedSummaryViewType = .quotes
                                    showStatsSummary = true
                                } )
                                    .padding()
                                StatButtonView(label: "Invoices", value: "1000", tapAction: {
                                    selectedSummaryViewType = .invoices
                                    showStatsSummary = true
                                } )
                                    .padding()
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
                StatsSummaryView(selectedStat: $selectedSummaryViewType, invoices: invoices, expenses: expenses,activeSheet: $activeSheet)
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

