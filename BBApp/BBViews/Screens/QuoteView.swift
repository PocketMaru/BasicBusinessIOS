//
//  QuoteView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct QuoteView: View {
    @Bindable var userVM: UserVM
    @Bindable var quoteVM: QuoteVM
    @Bindable var customerListVM: CustomerListVM
    @Binding var activeSheet: ActiveUserSheet?
    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel = .sample

    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if selectedCustomer.id == CustomerModel.sample.id {
                        CustomFormView(header: "Select Customer") {
                            HStack {
                                TextField ("Search Customer", text: $searchCustomer)
                                if !searchCustomer.isEmpty || selectedCustomer.id != CustomerModel.sample.id {
                                    Button {
                                        searchCustomer = ""
                                        selectedCustomer = .sample
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    let results = customerListVM.searchCustomer(by: searchCustomer)
                    if !searchCustomer.isEmpty {
                        if results.isEmpty {
                            HStack(alignment: .center) {
                                Spacer()
                                Text("No Customer Found")
                                    .bubbleStyle()
                                    .statButtonBG()
                                Spacer()
                            }
                        } else {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(results, id: \.id) { customer in
                                    Button {
                                        selectedCustomer = customer
                                        searchCustomer = ""
                                    } label: {
                                        HStack(spacing: 8) {
                                            Spacer()
                                            Text("\(customer.firstName) \(customer.lastName)")
                                                .bubbleStyle()
                                                .statButtonBG()
                                            Spacer()
                                            if selectedCustomer.id == customer.id {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(AppColors.accent)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else if selectedCustomer.id != CustomerModel.sample.id {
                        VStack(alignment: .leading, spacing: 16) {
                            CustomFormView(header: "Customer") {
                                HStack {
                                    Text("\(selectedCustomer.firstName) \(selectedCustomer.lastName)")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                    Button {
                                        selectedCustomer = .sample
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            // MARK: Cases representing industry specific fields.
                            
                                Group{
                                    switch userVM.user.industryType {
                                    case .landscaping:
                                        LandscapeSectionView(quoteVM: quoteVM)
                                    case .pressureWashing:
                                        PressureWashSectionView(quoteVM: quoteVM)
                                    case .consulting:
                                        ConsultingSectionView(quoteVM: quoteVM)
                                    case .handyman:
                                        HandymanSectionView(quoteVM: quoteVM)
                                    case .HVAC:
                                        HVACSectionView(quoteVM: quoteVM)
                                    case .productSales:
                                        ProductSalesSectionView(quoteVM: quoteVM)
                                    case .none:
                                        EmptyView()
                                    }
                                }
                            
                            CustomFormView(header: "Total") {
                                Text("\(quoteVM.draftQuote.totalCost)")
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // MARK: Check to avoid resetting of the draft quote on view re-render
            // MARK: On selection of a different customer, quote data is reset
            quoteVM.loadIndustryFields(for: userVM.user.industryType)
            quoteVM.draftQuote = quoteVM.startNewQuote(for: selectedCustomer, industry: userVM.user.industryType)
        }
        .onChange(of: selectedCustomer) { newCustomer, _ in
            quoteVM.loadIndustryFields(for: userVM.user.industryType)
                quoteVM.draftQuote = quoteVM.startNewQuote(
                    for: newCustomer,
                    industry: userVM.user.industryType
                )
        }
        .ToolBarTitle(
            title: userVM.user.businessName,
            editIconName: "plusminus.circle",
            editButtonColor: activeSheet == nil ? AppColors.accent : AppColors.success,
            mainIconTapped: {
                if activeSheet == nil {
                    activeSheet = .user
                }
        }, editIconTapped: {
            
        })
    }
}
