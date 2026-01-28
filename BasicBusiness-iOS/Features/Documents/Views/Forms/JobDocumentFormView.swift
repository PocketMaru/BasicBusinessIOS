import SwiftUI

struct JobDocumentFormView: View {
    var userVM: UserVM
    var form: JobDocumentRouterFeature
    var customers: [CustomerModel]
    
    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel? = nil
    
    var body: some View {
        if let adapter = form.adapter {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        CustomerSelectionSection(
                            customers: customers,
                            searchCustomer: $searchCustomer,
                            selectedCustomer: $selectedCustomer
                        )
                        ServiceSection(
                            serviceType: adapter.serviceType,
                            customServiceName: adapter.customService,
                            isVisible: selectedCustomer != nil
                        )
                        DateSection(
                            documentDate: adapter.creationDate,
                            documentDueDate: adapter.dueDate,
                            installationDate: adapter.installationDate,
                            serviceDate: adapter.serviceDate,
                            customDateRange: adapter.customDate,
                            applyNetTerms: adapter.netTerms,
                            isVisible: selectedCustomer != nil
                        )
                        IndustryPricingSection(
                            industryType: userVM.user.industryType,
                            pricingMethods: adapter.pricingMethods,
                            isVisible: selectedCustomer != nil
                        )
                        CustomFieldSection(
                            customFields: adapter.customFields,
                            isVisible: selectedCustomer != nil
                        )
                        NoteSection(
                            notes: adapter.notes,
                            isVisible: selectedCustomer != nil
                        )
                        TotalSection(
                            total: adapter.total,
                            isVisible: selectedCustomer != nil
                        )
                    }
                    .statBubbleStyle()
                    .statButtonBG(emphasis: .raised)
                    .padding(.horizontal, 10)
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ToolBarTitle(
                title: adapter.formTitle,
                primaryIconName: nil,
                thirdIconName: selectedCustomer != nil ? "checkmark.circle.fill" : nil,
                thirdIconColor: AppColors.accent,
                thirdIconTapped: {
                    // Confirm Document
                }
            )
        }
    }
}
