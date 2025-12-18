import SwiftUI

struct JobDocumentListView: View {
    var userVM: UserVM
    @Bindable var jobDocRouter: JobDocumentRouterVM
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
                                        value: JobDocumentRouterVM.JobDocumentRoute.quoteDetail(id: row.id)) {
                                            JobDocumentItemView(document: row)
                                        }
                                }
                            case .invoice:
                                ForEach(jobDocRouter.invoiceRowsFilteredByDate) { row in
                                    NavigationLink(value:JobDocumentRouterVM.JobDocumentRoute.invoiceDetail(id: row.id)) {
                                        JobDocumentItemView(document: row)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top, 25)
                    .scrollContentBackground(.hidden)
                    .navigationDestination(item: $jobDocRouter.route ) {
                        route in
                        switch route {
                        case .quoteDetail(let id):
//                            if let quote = jobDocRouter
//                                .quote(withID: id),
//                                let customer = jobDocRouter
//                                .customer(for: quote.customerID) {
//                                JobDocumentDetailView(
//                                    detail: .quote(quote),
//                                    customer: customer
//                                )
//                            }
                            
                            if let quote = jobDocRouter.quote(withID: id) {
                                JobDocumentDetailView(
                                    detail: .quote(quote),
                                    customer: CustomerModel.mockList[2]
                                )
                            }
                        case .invoiceDetail(let id):
    //                        if let invoice = jobDocRouter
    //                            .invoice(withID: id),
    //                            let customer = jobDocRouter
    //                            .customer(for: invoice.customerID) {
    //                            JobDocumentDetailView(
    //                                detail: .invoice(invoice),
    //                                customer: customer
    //                            )
    //                        }
                            
                            if let invoice = jobDocRouter.invoice(withID: id) {
                                JobDocumentDetailView(
                                    detail: .invoice(invoice),
                                    customer: CustomerModel.mockList[2]
                                )
                            }
                        case .createQuote:
                            JobDocumentFormView(
                                userVM: userVM,
                                form: jobDocRouter.form(for: .quote),
                                customers: jobDocRouter.customerListVM.allCustomers,
                                activeSheet: $activeSheet
                            )
                        case .createInvoice:
                            JobDocumentFormView(
                                userVM: userVM,
                                form: jobDocRouter.form(for: .invoice),
                                customers: jobDocRouter.customerListVM.allCustomers,
                                activeSheet: $activeSheet
                            )
                        case .editQuote:
                            // navigation logic to edit view with doc id in quote context
                            EmptyView()
                        case .editInvoice:
                            // navigation logic to edit view with doc id in invoice context
                            EmptyView()
                        }
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
                jobDocRouter.route = .createQuote
            },
            onCreateInvoice: {
                jobDocRouter.route = .createInvoice
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
