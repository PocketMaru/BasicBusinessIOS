import SwiftUI

struct JobDocumentDetailView: View {
    var router: JobDocumentRouterFeature
    var route: JobDocumentRouterFeature.JobDocumentRoute
    var customer: CustomerModel
    @State private var isEditing: Bool = false
    @State private var attemptedSave: Bool = false
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 16) {
                    switch route {
                    case .quoteDetail(let id):
                        if let quote = router.quote(withID: id) {
                            DocumentDetailContent(
                                document: .quote(quote),
                                customer: customer
                            )
                        }
                    case .invoiceDetail(let id):
                        if let invoice = router.invoice(withID: id) {
                            DocumentDetailContent(
                                document: .invoice(invoice),
                                customer: customer
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .scrollContentBackground(.hidden)
        .ToolBarTitle(
            title: customer.displayName,
            primaryIconName: nil,
            editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
            editIconTapped: {
                switch route {
                case .quoteDetail(let id):
                    router.startEditingQuote(id: id)
                case .invoiceDetail(let id):
                    router.startEditingInvoice(id: id)
                }
            },
            editIconColor: AppColors.accent
        )
    }
}
