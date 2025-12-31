import SwiftUI

struct DocumentDetailContent: View {
    var document: JobDocumentRouterFeature.JobDocumentDetail
    var customer: CustomerModel
    var body: some View {
        
        switch document {
        case .quote(let quote):
            MultiForm(fields: [
                .init(
                    title: "Customer",
                    value: customer.displayName,
                    edit: EditControl.none
                    ),
                .init(
                    title: "Industry",
                    value: quote.industryType.displayName,
                    edit: EditControl.none
                     ),
                .init(
                    title: "Service",
                    value: quote.serviceType.id,
                    edit: EditControl.none
                     ),
                .init(
                    title: "Pricing Method",
                    value: nil,
                    edit: EditControl.none
                     ),
                .init(
                    title: "Notes",
                    value: quote.notes ?? "No Notes",
                    edit: EditControl.none
                     )
            ], isEditing: false)
        case .invoice(let invoice):
            MultiForm(fields: [
                .init(
                    title: "Customer",
                    value: customer.displayName,
                    edit: EditControl.none
                    ),
                .init(
                    title: "Industry",
                    value: invoice.industryType.displayName,
                    edit: EditControl.none
                     ),
                .init(
                    title: "Service",
                    value: invoice.serviceType.id,
                    edit: EditControl.none
                     ),
                .init(
                    title: "Pricing Method",
                    value: nil,
                    edit: EditControl.none
                     ),
                .init(title: "Notes",
                      value: invoice.notes ?? "No Notes",
                      edit: EditControl.none
                     )
            ], isEditing: false)
        }
    }
}
