import SwiftUI

struct JobDocumentFormView: View {
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
        .ToolBarTitle(
            businessName: userVM.user.businessName,
            primaryIconTapped: {
                if activeSheet == nil {
                    activeSheet = .user
                }
            }, secondIconName: "plusminus.circle",
            secondButtonColor: activeSheet == nil ? AppColors.accent : AppColors.success,
            secondIconTapped: {
            
        })
    }
    
    // MARK: - Constants
    
    private var customerSelectionSection: some View {
        Group {
            if selectedCustomer == nil {
                CustomFormView(header: "Select Customer") {
                    HStack{
                        TextField ("Search Customer", text: $searchCustomer)
                        if !searchCustomer.isEmpty {
                            Button {
                                searchCustomer = ""
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
    
    private var searchResultsSection: some View {
        Group {
            if !searchCustomer.isEmpty {
                let results = customerListVM.searchCustomer(by: searchCustomer)
                if results.isEmpty {
                    HStack(alignment: .center) {
                        Text("No Customer Found")
                            .bubbleStyle()
                            .statButtonBG()
                    }
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(results, id: \.id) { customer in
                            Button {
                                selectedCustomer = customer
                                searchCustomer = ""
                                
                                quoteFormVM = quoteListVM.addVM()
                                quoteFormVM?.selectCustomer(customer)
                                quoteFormVM?.loadIndustryFields(for: userVM.user.industryType)
                            } label: {
                                HStack(spacing: 8) {
                                    Text("\(customer.firstName) \(customer.lastName)")
                                        .bubbleStyle()
                                        .statButtonBG()
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
        Group {
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
        Group{
            if let totalCost = quoteFormVM?.draft.totalCost {
            CustomFormView(header: "Total") {
                Text(totalCost, format: .currency(code: "USD"))
                }
            }
        }
    }
}
