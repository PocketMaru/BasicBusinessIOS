import SwiftUI

struct QuoteView: View {
    var userVM: UserVM
    var customerListVM: CustomerListVM
    var quoteListVM: QuoteListVM
    
    @State private var quoteFormVM: QuoteFormVM? = nil
    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel? = nil
    
    @Binding var activeSheet: ActiveUserSheet?

    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    customerSelectionSection
                    searchResultsSection
                    customerSelectedSection
                    industrySelectedSection
                    totalSection
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedCustomer) { newCustomer, _ in
            if let customer = newCustomer {
                quoteFormVM = quoteListVM.addVM()
                quoteFormVM?.selectCustomer(customer)
                quoteFormVM?.loadIndustryFields(for: userVM.user.industryType)
            }
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
    private var customerSelectionSection: some View {
        CustomFormView(header: "Select Customer") {
            HStack {
                TextField ("Search Customer", text: $searchCustomer)
                if selectedCustomer != nil || !searchCustomer.isEmpty {
                    Button {
                        searchCustomer = ""
                        selectedCustomer = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    private var searchResultsSection: some View {
        Group {
            if !searchCustomer.isEmpty {
                let results = customerListVM.searchCustomer(by: searchCustomer)
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
                                    if selectedCustomer?.id == customer.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(AppColors.accent)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var customerSelectedSection: some View {
        Group {
            if let customer = selectedCustomer {
                VStack(alignment: .leading, spacing: 16) {
                    CustomFormView(header: "Customer") {
                        HStack {
                            Text("\(customer.firstName) \(customer.lastName)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Button {
                                selectedCustomer = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var industrySelectedSection: some View {
        Group{
            if let quoteFormVM = quoteFormVM {
                switch userVM.user.industryType {
                case .landscaping:
                    LandscapeSectionView(quoteFormVM: quoteFormVM)
                case .pressureWashing:
                    PressureWashSectionView(quoteFormVM: quoteFormVM)
                case .consulting:
                    ConsultingSectionView(quoteFormVM: quoteFormVM)
                case .handyman:
                    HandymanSectionView(quoteFormVM: quoteFormVM)
                case .HVAC:
                    HVACSectionView(quoteFormVM: quoteFormVM)
                case .productSales:
                    ProductSalesSectionView(quoteFormVM: quoteFormVM)
                case .none:
                    EmptyView()
                }
            }
        }
    }
    
    private var totalSection: some View {
        CustomFormView(header: "Total") {
            if let totalCost = quoteFormVM?.draft.totalCost {
                Text(totalCost, format: .currency(code: "USD"))
            }
        }
    }
}
