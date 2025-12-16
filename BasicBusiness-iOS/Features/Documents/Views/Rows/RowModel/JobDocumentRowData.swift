import Foundation

enum JobDocumentRowItem: Codable, Identifiable {
    case quote(QuoteModel)
    case invoice(InvoiceModel)
    
    var id: UUID {
        switch self {
        case .quote(let quote): return quote.id
        case .invoice(let invoice): return invoice.id
        }
    }
}

struct JobDocumentRowData: Codable, Identifiable {
    var id: UUID
    var customerName: String
    var totalCost: Double
    var date: Date
    var documentType: JobDocumentType
}
