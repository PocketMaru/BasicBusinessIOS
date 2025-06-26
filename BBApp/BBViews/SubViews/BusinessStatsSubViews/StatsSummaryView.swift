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
    var businessStatsVM: BusinessStatsVM
    var customerDetailVM: CustomerDetailVM?
    var customerListVM: CustomerListVM
    @State private var statDetailSheetItem: StatDetailSheetItem?
    @Binding var activeSheet: ActiveUserSheet?
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        if selectedStat == .invoices {
                            ForEach(invoiceVM.invoice.indices, id: \.self) { index in
                                let invoice = invoiceVM.invoice[index]
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
                                if index < invoiceVM.invoice.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                            
                        } else if selectedStat == .expenses {
                            ForEach(expenseVM.expenses.indices, id: \.self) { index in
                                let expense = expenseVM.expenses[index]
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
                                if index < expenseVM.expenses.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        } else if selectedStat == .income {
                            CustomSectionView(headerTitle:"Totals") {
                                VStack {
                                    Text("Total Invoices: \(invoiceVM.invoice.count)")
                                    Divider()
                                    Text("Total Quotes: \(quoteVM.quotes.count)")
                                    Divider()
                                    Text("ForeCasted Revenue: \(quoteVM.quotes.reduce(0) { $0 + ($1.totalCost ?? 0)})")
                                    Divider()
                                    Text("Actual Revenue: \(invoiceVM.invoice.reduce(0) { $0 + ($1.totalCost ?? 0)})")
                                }
                            }
                        } else if selectedStat == .quotes {
                            ForEach(quoteVM.quotes.indices, id: \.self) { index in
                                let quoteItem = quoteVM.quotes[index]
                                CustomSectionView(headerTitle: quoteItem.customer.fullName ?? quoteItem.customer.firstName) {
                                    VStack {
                                        Text(quoteItem.customer.phone)
                                        Divider()
                                        Text(String(quoteItem.quoteDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted)))
                                        Divider()
                                        Text(String(quoteItem.totalCost ?? 0))
                                        Spacer()
                                    }
                                } tapped: {
                                    statDetailSheetItem = .quote(quoteItem)
                                }
                                if index < quoteVM.quotes.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        } else if selectedStat == .materials {
                            
                        } else if selectedStat == .customers {
                                ForEach(customerListVM.allCustomers.indices, id: \.self) { index in
                                    let customer = customerListVM.allCustomers[index]
                                    CustomSectionView(headerTitle: customer.fullName ?? customer.firstName) {
                                        VStack {
                                            Text(customer.phone)
                                            Divider()
                                            Text(customer.address ?? "No Address Available")
                                            Divider()
                                            Text(customer.paidBill != nil ? "Paid" : "Unpaid")
                                        }
                                    } tapped: {
                                        statDetailSheetItem = .customer(customer)
                                    }
                                    if index < customerListVM.allCustomers.count - 1 {
                                        Divider()
                                            .padding(.horizontal)
                                    }
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
            .sheet(item: $statDetailSheetItem) { item in
                switch item {
                case .invoice(let invoice):
                    StatsSummaryDetailView(
                        selectedStat: $selectedStat,
                        invoice: invoice,
                        expense: nil,
                        quote: nil,
                        statDetailSheetItem: $statDetailSheetItem
                    )
                case .expense(let expense):
                    StatsSummaryDetailView(
                        selectedStat: $selectedStat,
                        invoice: nil,
                        expense: expense,
                        quote: nil,
                        statDetailSheetItem: $statDetailSheetItem
                    )
                case .income(_):
                    Text("Income")
                case .quote(_):
                    Text("Quote")
                case .customer(let customer):
                    StatsSummaryDetailView(
                        selectedStat: $selectedStat,
                        invoice: nil,
                        expense: nil,
                        quote: nil,
                        customer: customer,
                        statDetailSheetItem: $statDetailSheetItem
                    )
                case .material(_):
                    Text("Material")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
