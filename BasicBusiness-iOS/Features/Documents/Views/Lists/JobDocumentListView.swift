import SwiftUI

enum DocumentTapped {
    case quote([QuoteModel])
    case invoice([InvoiceModel])
    case none
}

extension DocumentTapped {
    var allQuotes: [QuoteModel] {
        switch self {
        case .quote(let quotes): return quotes
        case .invoice: return []
        case .none: return []
        }
    }
    
    var allInvoices: [InvoiceModel] {
        switch self {
        case .quote: return []
        case .invoice(let invoices): return invoices
        case .none: return []
        }
    }
}

struct JobDocumentListView: View {
    var userVM: UserVM
    var jobDocRouter: JobDocumentRouterVM
    @State private var documentType: DocumentTapped = .none
    
    var displayQuotes: [QuoteModel] {
        if case .quote(let quotes) = documentType {
            return quotes
        }
        return []
    }
    
    var displayInvoices: [InvoiceModel] {
        if case .invoice(let invoices) = documentType {
            return invoices
        }
        return []
    }

    var body: some View {
        
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ZStack {
                HStack {
                    StatButtonView(label: "Quotes",
                                   tapAction: {
                        documentType = .quote(jobDocRouter.quoteListVM.allQuotes)
                    })
                    
                    StatButtonView(label: "Invoices",
                                   tapAction: {
                        documentType = .invoice(jobDocRouter.invoiceListVM.allInvoices)
                    })
                }
                List {
                    switch documentType {
                    case .quote(let quotes):
                        ForEach(quotes) { quote in
                            // Navigation link to detail
                            // QuoteRowView
                        }
                        
                    case .invoice(let invoices):
                        ForEach(invoices) { invoice in
                            // Navigation link to detail
                            // InvoiceRowView
                        }
                        
                    case .none:
                        Text("Select Document Type")
                    }
                }
                // navigation destination
                // Example
                
//                .navigationDestination(for: JobDocument.self) {                                                doc in
//                    switch doc {
//                    case .quote(let q):
//                        QuoteDetailView(...)
//                    case .invoice(let i):
//                        InvoiceDetailView(...)
//                    }
//                }
            }
        }
        // navigation title inline
        // toolbar
        // frame maxW maxH .infinit .infinit
    }
}
