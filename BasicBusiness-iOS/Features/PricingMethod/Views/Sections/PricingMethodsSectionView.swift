import SwiftUI

struct PricingMethodsSectionView: View {
    @Binding var pricingMethods: [PricingMethodModel]
    @State private var showAddMethod = false
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            ForEach($pricingMethods) { $method in
                HStack {
                    PricingMethodFormView(method: $method)
                    Spacer()
                    Button {
                        deleteMethod(id: method.id)
                    } label: {
                        if #available(iOS 26.0, *) {
                            Image(systemName: "minus.circle")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(AppColors.accent)
                                .frame(width: 36, height: 36)
                                .background(
                                    Circle()
                                        .stroke(AppColors.accent.opacity(0.25), lineWidth: 1)
                                )
                                .contentShape(Circle())
                                .buttonStyle(.plain)
                                .glassEffect()
                        }
                    }
                }
            }
        } label: {
            addMethod()
        }
        .padding(.trailing, 20)
    }
    
    private func addMethod() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Pricing Methods")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 10)
                Spacer()
                if #available(iOS 26.0, *) {
                    Button {
                        showAddMethod = true
                    } label: {
                        Image(systemName: "document.badge.plus")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(AppColors.accent)
                            .frame(width: 36, height: 36)
                            .background(
                                Circle()
                                    .stroke(AppColors.accent.opacity(0.25), lineWidth: 1)
                            )
                            .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .glassEffect()
                    .confirmationDialog(
                        "Add Pricing Method",
                        isPresented: $showAddMethod
                    ) {
                        ForEach(PricingMethodType.allCases.filter { $0 != .none }, id: \.self) { type in
                            Button(type.rawValue) {
                                pricingMethods.append(.make(type))
                                isExpanded = true
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
    
    private func deleteMethod(id: UUID) {
        pricingMethods.removeAll { $0.id == id }
        if pricingMethods.isEmpty {
            isExpanded = false
        }
    }
}
