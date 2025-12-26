import SwiftUI

struct PricingMethodsSectionView: View {
    @Binding var pricingMethods: [PricingMethodModel]
    @State private var showAddMethod = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            ForEach($pricingMethods) { $method in
                PricingMethodFormView(method: $method)
            }
            
            Button {
                showAddMethod = true
            } label: {
                Label("Add Pricing Method", systemImage: "plus.circle")
                    .foregroundStyle(AppColors.accent)
            }
            .confirmationDialog(
                "Add Pricing Method",
                isPresented: $showAddMethod
            ) {
                ForEach(PricingMethodType.allCases.filter { $0 != .none }, id: \.self) { type in
                    Button(type.rawValue) {
                        pricingMethods.append(.make(type))
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
