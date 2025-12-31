import SwiftUI

struct CustomFieldSection: View {
    @Binding var customFields: [CustomField]
    @State private var isExpanded: Bool = false
    let isVisible: Bool
    
    var body: some View {
        if isVisible {
            Divider()
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach($customFields) { $field in
                    HStack {
                        CustomFieldFormSection(
                            customField: $field)
                        Spacer()
                        Button {
                            deleteField(id: field.id)
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
                addField()
            }
            .padding(.trailing, 20)
        }
    }
    
    private func addField() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Custom Fields")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 10)
                Spacer()
                if #available(iOS 26.0, *) {
                    Button {
                        $customFields.wrappedValue.append(.make())
                        isExpanded = true
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
                            .buttonStyle(.plain)
                            .glassEffect()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
    
    private func deleteField(id: UUID) {
        customFields.removeAll { $0.id == id }
        if customFields.isEmpty {
            isExpanded = false
        }
    }
}
