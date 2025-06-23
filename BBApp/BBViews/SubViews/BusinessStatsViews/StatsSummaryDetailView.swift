//
//  StatsSummaryDetailView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/20/25.
//

import SwiftUI

struct StatsSummaryDetailView: View {
    @Environment(\.dismiss) var dismissSheet
    @Binding var selectedStat: StatsSummaryViewType
    var customerDetail: CustomerDetailVM?
    var invoice: InvoiceModel?
    var expense: ExpenseModel?
    @Binding var statDetailSheetItem: StatDetailSheetItem?
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        switch statDetailSheetItem {
                        case .invoice:
                            if let invoice = invoice {
                                CustomSectionView(headerTitle: invoice.customer.fullName ?? "Unknown") {
                                    VStack {
                                        Text(invoice.serviceType.name)
                                        Divider()
                                        Text(invoice.invoiceDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted))
                                        Divider()
                                        if let notes = invoice.notes, !notes.isEmpty {
                                            Text(invoice.notes ?? "")
                                            Divider()
                                        }
                                        
                                        Text(String(invoice.totalCost?.formatted() ?? "0.00"))
                                    }
                                }
                            }
                        case .expense:
                            if let expense = expense {
                                CustomSectionView(headerTitle: expense.name) {
                                    VStack {
                                        Text(expense.date.formatted(date: .abbreviated, time: .omitted))
                                        Divider()
                                        Text(expense.type.name)
                                        Divider()
                                        Text(String(expense.total.formatted()))
                                    }
                                }
                            }
                        case .income:
                            Text("Income")
                        case .quote:
                            Text("Quotes")
                        case .none:
                            Text("None")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(AppColors.bg)
                }
            }
            .ToolBarTitle(title: selectedStat.title, iconName: "arrowshape.backward.circle.fill", mainIconTapped: {
                dismissSheet()
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

