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
    
    var id: UUID {
        switch self {
        case .invoice(let invoice): return invoice.id
        case .expense(let expense): return expense.id
        case .income(let invoice): return invoice.id
        case .quote(let quote): return quote.id
        }
    }
    
    var statType: StatsSummaryViewType {
        switch self {
        case .invoice: return .invoices
        case .expense: return .expenses
        case .income: return .invoices
        case .quote: return .quotes
        }
    }
}

struct StatsSummaryView: View {
    @Binding var selectedStat: StatsSummaryViewType
    var invoices: InvoiceVM
    var expenses: ExpenseVM
    var businessStats: BusinessStatsVM?
    var customerDetail: CustomerDetailVM?
    @State private var statDetailSheetItem: StatDetailSheetItem?
    @Binding var activeSheet: ActiveUserSheet?
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        if selectedStat == .invoices {
                            ForEach(invoices.invoice.indices, id: \.self) { index in
                                let invoice = invoices.invoice[index]
                                CustomSectionView(headerTitle: invoice.customer.fullName ?? invoice.customer.firstName
                                ) {
                                    VStack {
                                        Text(invoice.customer.phone)
                                        Divider()
                                        Text(String(invoice.invoiceDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted)))
                                        Divider()
                                        Text(String(invoice.totalCost ?? 0))
                                        Spacer()
                                    }
                                } tapped: {
                                    statDetailSheetItem = .invoice(invoice)
                                }
                                if index < invoices.invoice.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                            
                        } else if selectedStat == .expenses {
                            ForEach(expenses.expenses.indices, id: \.self) { index in
                                    let expense = expenses.expenses[index]
                                    CustomSectionView(headerTitle: expense.name) {
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
                                if index < expenses.expenses.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        } else if selectedStat == .income {
                            CustomSectionView(headerTitle: "Total Income") {
                                VStack {
                                    if let stats = businessStats {
                                        Text("Invoiced Revenue: \(stats.invoicedRevenue)")
                                        Divider()
                                        Text("\(stats.confirmedExpenses)")
                                        Divider()
                                    }
                                    
                                    
                                }
                                Text(String(invoices.invoice.reduce(0) { $0 + ($1.totalCost ?? 0)}))
                            }
                        } else if selectedStat == .quotes {
                            
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .ToolBarTitle(title: selectedStat.title, mainIconTapped: {
                activeSheet = .user
            })
            .sheet(item: $statDetailSheetItem) { item in
                switch item {
                case .invoice(let invoice):
                    StatsSummaryDetailView(
                        selectedStat: $selectedStat,
                        invoice: invoice,
                        expense: nil,
                        statDetailSheetItem: $statDetailSheetItem
                    )
                case .expense(let expense):
                    StatsSummaryDetailView(
                        selectedStat: $selectedStat,
                        invoice: nil,
                        expense: expense,
                        statDetailSheetItem: $statDetailSheetItem
                    )
                case .income(_):
                    Text("Income")
                case .quote(_):
                    Text("Quote")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
