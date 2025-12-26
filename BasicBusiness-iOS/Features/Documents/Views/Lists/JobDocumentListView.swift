import SwiftUI

struct JobDocumentListView: View {
    var userVM: UserVM
    @Bindable var jobDocRouter: JobDocumentRouterFeature
    @Binding var activeSheet: ActiveUserSheet?
    @State private var documentType: JobDocumentType = .quote
    
    @State private var showCalendarMenu = false
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            VStack(spacing: 0) {
                documentTypeHeader
                ScrollView {
                    VStack {
                        VStack(alignment: .center ,spacing: 16) {
                            switch documentType {
                            case .quote:
                                ForEach(jobDocRouter.quoteRowsFilteredByDate) { row in
                                    NavigationLink(
                                        value: JobDocumentRouterFeature.JobDocumentRoute.quoteDetail(id: row.id)) {
                                            JobDocumentItemView(document: row)
                                        }
                                }
                            case .invoice:
                                ForEach(jobDocRouter.invoiceRowsFilteredByDate) { row in
                                    NavigationLink(value:JobDocumentRouterFeature.JobDocumentRoute.invoiceDetail(id: row.id)) {
                                        JobDocumentItemView(document: row)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 25)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: JobDocumentRouterFeature.JobDocumentRoute.self ) {
                        route in
                        switch route {
                        case .quoteDetail(let id):
                            if let quote = jobDocRouter
                                .quote(withID: id),
                               let customer = jobDocRouter
                                .customer(for: quote.customerID) {
                                JobDocumentDetailView(
                                    detail: .quote(quote),
                                    customer: customer
                                )
                            }
                        case .invoiceDetail(let id):
                            if let invoice = jobDocRouter
                                .invoice(withID: id),
                               let customer = jobDocRouter
                                .customer(for: invoice.customerID) {
                                JobDocumentDetailView(
                                    detail: .invoice(invoice),
                                    customer: customer
                                )
                            }
                        }
                    }
                    .navigationDestination(item: $jobDocRouter.activeForm) { form in
                        JobDocumentFormView(
                            userVM: userVM,
                            form: form,
                            customers: jobDocRouter.customerFeatureVM.allCustomers,
                            activeSheet: $activeSheet
                        )
                    }
                }
                .mask(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0.0),
                            .init(color: .black, location: 0.04),
                            .init(color: .black, location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .ToolBarTitle(
            businessName: userVM.user.businessName,
            primaryIconTapped: {
                if activeSheet == nil {
                    activeSheet = .user
                }
            },
            calendarAction: { filter in
                jobDocRouter.documentDateFilter = filter
            },
            onCreateQuote: {
                jobDocRouter.startCreating(.quote)
            },
            onCreateInvoice: {
                jobDocRouter.startCreating(.invoice)
            }
        )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var documentTypeHeader: some View {
        HStack(spacing: 25) {
            StatButtonView(
                label: "Quotes",
                tapAction: { documentType = .quote },
                isSelected: documentType == .quote
            )

            StatButtonView(
                label: "Invoices",
                tapAction: { documentType = .invoice },
                isSelected: documentType == .invoice
            )
        }
        .padding(.top, 12)
        .padding(.vertical, 15)
    }
}
