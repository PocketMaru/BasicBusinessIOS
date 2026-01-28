import SwiftUI

struct DocumentDetailContent: View {
    var document: JobDocumentRouterFeature.JobDocumentDetail
    var customer: CustomerModel
    var body: some View {
        #warning("Create content view for documents")
        switch document {
        case .quote(let quote):
            EmptyView()
        case .invoice(let invoice):
            EmptyView()
        }
    }
}
