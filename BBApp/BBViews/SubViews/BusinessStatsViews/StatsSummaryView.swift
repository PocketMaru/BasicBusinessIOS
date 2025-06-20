//
//  StatsSummaryView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI


struct StatsSummaryView: View {
    var invoices: InvoiceVM
    var expenses: ExpenseVM
    var selectedStat: StatsSummaryViewType
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        if selectedStat == .invoices {
                            ForEach(invoices.invoice) { invoice in
                                CustomSectionView(headerTitle: invoice.customer.fullName ?? invoice.customer.firstName) {
                                    HStack {
                                        Spacer()
                                        Text(String(invoice.invoiceDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted)))
                                        Spacer()
                                        Text(String(invoice.totalCost ?? 0))
                                        Spacer()
                                    }
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
                                    }
                                if index < expenses.expenses.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        } else if selectedStat == .income {
                            Section(header: Text("Income")) {
                                Text(String(invoices.invoice.reduce(0) { $0 + ($1.totalCost ?? 0)}))
                            }
                        }
                        
                    }
                }
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .ToolBarTitle(title: selectedStat.title, mainIconTapped: {
                activeSheet = .user
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
