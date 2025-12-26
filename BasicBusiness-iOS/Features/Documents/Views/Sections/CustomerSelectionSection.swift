import SwiftUI

struct CustomerSelectionSection: View {
    var customers: [CustomerModel]
    @Binding var searchCustomer: String
    @Binding var selectedCustomer: CustomerModel?
    var body: some View {
        customerSelectionSection(from: customers)
    }
    
    @ViewBuilder
    private func customerSelectionSection(
        from customer: [CustomerModel]
    ) -> some View {
        Group {
            if selectedCustomer == nil {
                CustomFormView(header: "Select Customer") {
                    HStack{
                        TextField ("Search Customer", text: $searchCustomer)
                        if !searchCustomer.isEmpty {
                            Button {
                                searchCustomer = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            searchResultsSection(from: customer)
            customerSelectedSection(
                using: $selectedCustomer
            )
        }
    }
    
    private func searchResultsSection(
        from customer: [CustomerModel]
    ) -> some View {
        Group {
            if !searchCustomer.isEmpty {
                let results = customer.filter {
                    $0.displayName
                        .localizedCaseInsensitiveContains(searchCustomer)
                }
                if results.isEmpty {
                    HStack(alignment: .center) {
                        Text("No Customer Found")
                            .bubbleStyle()
                            .statButtonBG()
                    }
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(results, id: \.id) { customer in
                            Button {
                                selectedCustomer = customer
                                searchCustomer = ""
                            } label: {
                                HStack(spacing: 8) {
                                    Text("\(customer.firstName) \(customer.lastName)")
                                        .bubbleStyle()
                                        .statButtonBG()
                                    if selectedCustomer?.id == customer.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(AppColors.accent)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func hasSelectedCustomer(from customer: Binding<CustomerModel?>) -> Bool {
        customer.wrappedValue != nil
    }
    
    private func customerSelectedSection(
        using selectedCustomer: Binding<CustomerModel?>
    ) -> some View {
        Group {
            if hasSelectedCustomer(from: selectedCustomer), let customer = selectedCustomer.wrappedValue {
                VStack(alignment: .center, spacing: 16) {
                    CustomFormView(header: "Customer") {
                        HStack {
                            Text("\(customer.firstName) \(customer.lastName)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            Button {
                                selectedCustomer.wrappedValue = nil
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
    }
}
