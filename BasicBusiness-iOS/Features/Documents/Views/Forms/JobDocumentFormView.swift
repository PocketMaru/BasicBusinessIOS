import SwiftUI

struct JobDocumentFormView: View {
    var userVM: UserVM
    var form: JobDocumentRouterFeature.JobDocumentForm
    var customers: [CustomerModel]
    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel? = nil
    @Binding var activeSheet: ActiveUserSheet?

    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    CustomerSelectionSection(
                        customers: customers,
                        searchCustomer: $searchCustomer,
                        selectedCustomer: $selectedCustomer
                    )
                    IndustryPricingSection(
                        industryType: userVM.user.industryType,
                        form: form
                    )
                    totalSection(from: form)
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
        from form: JobDocumentRouterFeature.JobDocumentForm
    ) -> String{
        switch form {
            case .quote:
            return "Create Quote"
        case .invoice:
            return "Create Invoice"
        }
    }
    
    private func totalSection(
        from form: JobDocumentRouterFeature.JobDocumentForm)
    -> some View {
        Group{
            switch form {
            case .quote(id: _, vm: let quoteVM):
                CustomFormView(header: "Total") {
                    Text(quoteVM.draft.totalCost, format: .currency(code: "USD"))
                    }
            case .invoice(id: _, vm: let invoiceVM):
                CustomFormView(header: "Total") {
                    Text(invoiceVM.draft.totalCost, format: .currency(code: "USD"))
                    }
            }
        }
    }
    
//    private func sharedFormFields(
//        from form: JobDocumentRouterVM.JobDocumentForm
//    ) -> some View {
//        Group{
//            switch form {
//            case .quote(_, vm: let quoteVM):
//                let bindableQuoteVM = Bindable(quoteVM)
//                CustomFormView(header: "Industry Type") {
//                    Picker(
//                        "Industry",
//                        selection: bindableQuoteVM.draft.industryType
//                    ) {
//                        ForEach(IndustryChoice.all) { choice in
//                            Text(choice.displayName)
//                                .tag(choice.type)
//                        }
//                    }
//                }
//                
//                CustomFormView(header: "Service Type") {
//                    Picker(
//                        "Industry",
//                        selection: bindableQuoteVM.draft.serviceType
//                    ) {
//                        ForEach(ServiceChoice.all) { choice in
//                            Text(choice.displayName)
//                                .tag(choice.type)
//                        }
//                    }
//                }
//            case .invoice(_, vm: let invoiceVM):
//                let bindableInvoiceVM = Bindable(invoiceVM)
//                CustomFormView(header: "Industry Type") {
//                    Picker(
//                        "Industry",
//                        selection: bindableInvoiceVM.draft.industryType
//                    ) {
//                        ForEach(IndustryChoice.all) { choice in
//                            Text(choice.displayName)
//                                .tag(choice.type)
//                        }
//                    }
//                }
//                
//                CustomFormView(header: "Service Type") {
//                    Picker(
//                        "Industry",
//                        selection: bindableInvoiceVM.draft.serviceType
//                    ) {
//                        ForEach(ServiceChoice.all) { choice in
//                            Text(choice.displayName)
//                                .tag(choice.type)
//                        }
//                    }
//                }
//            }
//        }
//    }
}
