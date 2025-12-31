import SwiftUI

struct JobDocumentDetailView: View {
    var detail: JobDocumentRouterFeature.JobDocumentDetail
    var customer: CustomerModel
    @State private var isEditing: Bool = false
    @State private var attemptedEdit: Bool = false
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    switch detail {
                    case .quote(let quote):
                        DocumentDetailContent(
                            document: .quote(quote),
                            customer: customer
                        )
                    case .invoice(let invoice):
                        DocumentDetailContent(
                            document: .invoice(invoice),
                            customer: customer
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .scrollContentBackground(.hidden)
        .ToolBarTitle(
            businessName: customer.displayName,
            primaryIconName: nil,
            editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
            editIconTapped: nil
//                {
//                if isEditing {
//                    attemptedEdit = true
//                    let success = customer.trySubmit()
//                    if success {
//                        isEditing = false
//                        attemptedEdit = false
//                    }
//                } else {
//                    customer.cancelEdits()
//                    isEditing = true
//                    attemptedEdit = true
//                }
//            }
        )
    }
}
