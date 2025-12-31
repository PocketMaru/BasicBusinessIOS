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
            VStack {
                if selectedCustomer == nil {
                    HStack (alignment: .center, spacing: 5) {
                        TextField ("Search Customer", text: $searchCustomer)
                            .foregroundStyle(AppColors.secondaryText)
                            .padding(.top, 10)
                        if !searchCustomer.isEmpty {
                            Button {
                                searchCustomer = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(AppColors.secondaryText)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
                searchResultsSection(from: customer)
                customerSelectedSection(
                    using: $selectedCustomer
                )
            }
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
                    Divider()
                    HStack(alignment: .center) {
                        Text("No Customer Found")
                            .bubbleStyle()
                            .foregroundStyle(AppColors.secondaryText)
                    }
                } else {
                    VStack(alignment: .leading, spacing: 16) {
                        Divider()
                        ForEach(results, id: \.id) { customer in
                            Button {
                                selectedCustomer = customer
                                searchCustomer = ""
                            } label: {
                                HStack(spacing: 8) {
                                    Text("\(customer.firstName) \(customer.lastName)")
                                        .bubbleStyle()
                                        .padding(.bottom, 5)
                                    if selectedCustomer?.id == customer.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(AppColors.accent)
                                    }
                                }
                                .padding(.horizontal, 15)
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
                VStack(alignment: .leading, spacing: 16) {
                    Text("Customer")
                        .foregroundStyle(AppColors.accent)
                        .padding(.top, 12)
                        .padding(.horizontal, 15)
                    Divider()
                    HStack {
                        Text("\(customer.firstName) \(customer.lastName)")
                            .font(.subheadline)
                            .foregroundStyle(AppColors.secondaryText)
                        Button {
                            selectedCustomer.wrappedValue = nil
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 15)
                    Divider()
                }
            } else {
                EmptyView()
            }
        }
    }
}
