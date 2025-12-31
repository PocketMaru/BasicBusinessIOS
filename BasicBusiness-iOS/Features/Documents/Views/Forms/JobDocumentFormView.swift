import SwiftUI

struct JobDocumentFormView: View {
    var userVM: UserVM
    var form: JobDocumentRouterFeature.JobDocumentForm
    var customers: [CustomerModel]

    @State private var searchCustomer: String = ""
    @State private var selectedCustomer: CustomerModel? = nil
    
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    CustomerSelectionSection(
                        customers: customers,
                        searchCustomer: $searchCustomer,
                        selectedCustomer: $selectedCustomer
                    )
                    DateSection(
                        documentDate: form.creationDateBinding,
                        documentDueDate: form.dueDateBinding,
                        installationDate: form.installationDateBinding,
                        serviceDate: form.serviceDateBinding,
                        customDateRange: form.customDateRangeBinding,
                        isVisible: selectedCustomer != nil
                    )
                    ServiceSection(
                        serviceType: form.serviceTypeBinding,
                        customServiceName: form.selectedCustomService,
                        isVisible: selectedCustomer != nil
                    )
                    IndustryPricingSection(
                        industryType: userVM.user.industryType,
                        pricingMethods: form.pricingMethodsBinding,
                        isVisible: selectedCustomer != nil
                    )
                    CustomFieldSection(
                        customFields: form.customFieldsBinding,
                        isVisible: selectedCustomer != nil
                    )
                    NoteSection(
                        notes: form.notesBinding,
                        isVisible: selectedCustomer != nil
                    )
                    TotalSection(
                        total: form.total,
                        isVisible: selectedCustomer != nil
                    )
                }
                .statBubbleStyle()
                .statButtonBG(emphasis: .raised)
                .padding(.horizontal, 10)
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .navigationBarTitleDisplayMode(.inline)
        .ToolBarTitle(
            businessName: form.formTitle,
            primaryIconName: nil,
            thirdIconName: selectedCustomer != nil ? "checkmark.circle.fill" : nil,
            thirdIconTapped: {
                // Confirm Document
            }
        )
    }
}
