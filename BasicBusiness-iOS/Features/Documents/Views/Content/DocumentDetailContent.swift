import SwiftUI

struct DocumentDetailContent: View {
    var document: JobDocumentRouterVM.JobDocumentDetail
    var customer: CustomerModel
    var body: some View {
        
        switch document {
        case .quote(let quote):
            MultiForm(fields: [
                .init(
                    title: "Customer",
                    value: customer.displayName,
                    extraView: nil
                    ),
                .init(title: "Industry",
                      value: quote.industryType.displayName,
                      extraView: nil
                     ),
                .init(title: "Service",
                      value: quote.serviceType.name,
                      extraView: nil
                     ),
                .init(title: "Pricing Method",
                      value: nil,
                      extraView: {
                          AnyView (
                              IndustryRowView(industryType: quote.industryType)
                          )
                      }
                     ),
                .init(title: "Notes",
                      value: quote.notes ?? "No Notes",
                      extraView: nil
                     )
            ])
        case .invoice(let invoice):
            MultiForm(fields: [
                .init(
                    title: "Customer",
                    value: customer.displayName,
                    extraView: nil
                    ),
                .init(title: "Industry",
                      value: invoice.industryType.displayName,
                      extraView: nil
                     ),
                .init(title: "Service",
                      value: invoice.serviceType.name,
                      extraView: nil
                     ),
                .init(title: "Pricing Method",
                      value: nil,
                      extraView: {
                          AnyView (
                              IndustryRowView(industryType: invoice.industryType)
                          )
                      }
                     ),
                .init(title: "Notes",
                      value: invoice.notes ?? "No Notes",
                      extraView: nil
                     )
            ])
        }
    }
}
