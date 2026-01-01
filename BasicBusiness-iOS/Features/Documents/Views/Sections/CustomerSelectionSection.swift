import SwiftUI

struct CustomerSelectionSection: View {
    var customers: [CustomerModel]
    @Binding var searchCustomer: String
    @Binding var selectedCustomer: CustomerModel?
    @State private var isExpanded: Bool = true
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                customerSelectionSection(from: customers)
            }
            .padding(.horizontal, 15)
        } label: {
            VStack(alignment: .leading) {
                customerLabel()
            }
            .padding(.horizontal, 15)
        }
        .padding(.top,6)
        .padding(.trailing, 20)
        if selectedCustomer != nil {
            Divider()
        }
    }
    
    @ViewBuilder
    private func customerLabel() -> some View {
            if selectedCustomer == nil {
                Text("Select Customer")
                    .foregroundStyle(AppColors.accent)
            } else if selectedCustomer != nil {
                if isExpanded {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Customer")
                            .foregroundStyle(AppColors.accent)
                        Rectangle()
                            .fill(AppColors.accent.opacity(0.25))
                            .frame(width: 75, height: 1)
                    }
                } else {
                    HStack {
                        Text("Customer:")
                            .foregroundStyle(AppColors.accent)
                        if let customer = selectedCustomer {
                            Text("\(customer.firstName) \(customer.lastName)")
                                .foregroundStyle(AppColors.secondaryText)
                        }
                    }
                    
                }
            }
    }
    
    @ViewBuilder
    private func customerSelectionSection(
        from customer: [CustomerModel]
    ) -> some View {
            if selectedCustomer == nil {
                TextField ("Search Customer", text: $searchCustomer)
                    .foregroundStyle(AppColors.secondaryText)
            }
            searchResultsSection(from: customer)
            customerSelectedSection(
                using: $selectedCustomer
            )
    }
    
    @ViewBuilder
    private func searchResultsSection(
        from customer: [CustomerModel]
    ) -> some View {
        
            if !searchCustomer.isEmpty {
                let results = customer.filter {
                    $0.displayName
                        .localizedCaseInsensitiveContains(searchCustomer)
                }
                if results.isEmpty {
                    Divider()
                    HStack(alignment: .center) {
                        Text("No Customer Found")
                            .foregroundStyle(AppColors.secondaryText)
                    }
                } else {
                    Divider()
                    LazyVStack(alignment: .leading) {
                        ForEach(results, id: \.id) { customer in
                                Button {
                                    selectedCustomer = customer
                                    searchCustomer = ""
                                    isExpanded = false
                                } label: {
                                    HStack() {
                                        Text("\(customer.firstName) \(customer.lastName)")
                                            .foregroundStyle(AppColors.secondaryText)
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
    
    private func hasSelectedCustomer(from customer: Binding<CustomerModel?>) -> Bool {
        customer.wrappedValue != nil
    }
    
    @ViewBuilder
    private func customerSelectedSection(
        using selectedCustomer: Binding<CustomerModel?>
    ) -> some View {
        if hasSelectedCustomer(from: selectedCustomer), let customer = selectedCustomer.wrappedValue {
            VStack {
                HStack {
                    Text("Name:")
                        .foregroundStyle(AppColors.accent)
                    Text("\(customer.firstName) \(customer.lastName)")
                        .foregroundStyle(AppColors.secondaryText)
                    Button {
                        selectedCustomer.wrappedValue = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                
                HStack {
                    Text("Phone:")
                        .foregroundStyle(AppColors.accent)
                    Text("\(customer.phone)")
                        .foregroundStyle(AppColors.secondaryText)
                    Spacer()
                }
                
                HStack {
                    Text("Address:")
                        .foregroundStyle(AppColors.accent)
                    Text("\(customer.address ?? "")")
                        .foregroundStyle(AppColors.secondaryText)
                    Spacer()
                }
            }
        }
    }
}
