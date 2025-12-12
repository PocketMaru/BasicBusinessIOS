import SwiftUI

enum DocumentRowItem {
    case quote(QuoteModel)
    case invoice(InvoiceModel)
    
    var id: UUID {
        switch self {
        case .quote(let quote): return quote.id
        case .invoice(let invoice): return invoice.id
        }
    }
}

struct JobDocumentRowView: View {
    var document: DocumentRowItem
    var body: some View {
        switch document {
        case .quote(let quote):
            Text("")
            // QuoteRowContentView
        case .invoice(let invoice):
            Text("")
            // InvoiceRowContentView
        }
    }
}
