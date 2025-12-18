import SwiftUI

struct JobDocumentFormView: View {
    var userVM: UserVM
    var form: JobDocumentRouterVM.JobDocumentForm
    var customers: [CustomerModel]
    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel? = nil
    @Binding var activeSheet: ActiveUserSheet?

    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    customerSelectionSection(from: customers)
                    customerSelectedSection(
                        from: form,
                        with: userVM.user.industryType,
                        using: $selectedCustomer
                    )
                }
                .padding(.horizontal, 10)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ToolBarTitle(
            businessName: formTitle(from: form),
            primaryIconTapped: {
                if activeSheet == nil {
                    activeSheet = .user
                }
            },
            editIconName: "plusminus.circle",
            editButtonColor: activeSheet == nil ? AppColors.accent : AppColors.success,
            editIconTapped: {
            
            }
        )
    }
    // MARK: - Constants
    
    private func formTitle(
        from form: JobDocumentRouterVM.JobDocumentForm
    ) -> String{
        switch form {
            case .quote:
            return "Create Quote"
        case .invoice:
            return "Create Invoice"
        }
    }
    
    private func hasSelectedCustomer(from customer: Binding<CustomerModel?>) -> Bool {
        customer.wrappedValue != nil
    }
    
    private func customerSelectionSection(
        from customer: [CustomerModel]
    ) -> some View {
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
            searchResultsSection(from: customer)
        }
    }
    
    private func searchResultsSection(
        from customer: [CustomerModel]
    ) -> some View {
        Group {
            if !searchCustomer.isEmpty {
                let results = customer.filter {
                    $0.displayName
                        .localizedCaseInsensitiveContains(searchCustomer)
                }
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
    
    private func customerSelectedSection(
        from form: JobDocumentRouterVM.JobDocumentForm,
        with industryType: IndustryType,
        using selectedCustomer: Binding<CustomerModel?>
    ) -> some View {
        Group {
            if hasSelectedCustomer(from: selectedCustomer), let customer = selectedCustomer.wrappedValue {
                VStack(alignment: .leading, spacing: 16) {
                    CustomFormView(header: "Customer") {
                        HStack {
                            Text("\(customer.firstName) \(customer.lastName)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Button {
                                selectedCustomer.wrappedValue = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    sharedFormFields(from: form)
                    industrySelectedSection(from: industryType, with: form)
                    totalSection(from: form)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    private func industrySelectedSection(
        from industryType: IndustryType,
        with form: JobDocumentRouterVM.JobDocumentForm
    ) -> some View {
        Group {
            switch industryType {
            case .landscaping(_):
                LandscapeSectionView(form: form)
            case .pressureWashing(_):
                PressureWashSectionView(form: form)
            case .consulting(_):
                ConsultingSectionView(form: form)
            case .handyman(_):
                HandymanSectionView(form: form)
            case .HVAC(_):
                HVACSectionView(form: form)
            case .productSales(let priceModel):
                ProductSalesSectionView(form: form, priceModel: priceModel)
            case .none:
                EmptyView()
            }
        }
    }
    
    private func totalSection(
        from form: JobDocumentRouterVM.JobDocumentForm)
    -> some View {
        Group{
            switch form {
            case .quote(let quoteVM):
                CustomFormView(header: "Total") {
                    Text(quoteVM.draft.totalCost, format: .currency(code: "USD"))
                    }
            case .invoice(let invoiceVM):
                CustomFormView(header: "Total") {
                    Text(invoiceVM.draft.totalCost, format: .currency(code: "USD"))
                    }
            }
        }
    }
    
    private func sharedFormFields(from form: JobDocumentRouterVM.JobDocumentForm ) -> some View {
        Group{
            switch form {
            case .quote(let quoteVM):
                
                EmptyView()
            case .invoice(let invoiceVM):
                EmptyView()
            }
        }
    }
}
