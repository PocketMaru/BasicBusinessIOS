import SwiftUI

struct DateSection: View {
    @Binding var documentDate: Date
    @Binding var documentDueDate: Date
    @Binding var installationDate: Date
    @Binding var serviceDate: Date
    @Binding var customDateRange: Set<DateComponents>
    @State private var toggleOptional: Bool = false
    @State private var isExpanded: Bool = false
    @FocusState private var isFocused: Bool
    let isVisible: Bool
    
    var body: some View {
        if isVisible {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading) {
                    DatePicker(
                        "Creation Date",
                        selection: $documentDate,
                        displayedComponents: .date
                    )
                    .foregroundStyle(AppColors.secondaryText)
                    .padding(.horizontal, 15)
                    Divider()
                    DatePicker(
                        "Due Date",
                        selection: $documentDueDate,
                        displayedComponents: .date
                    )
                    .foregroundStyle(AppColors.secondaryText)
                    .padding(.horizontal, 15)
                    toggleOptionalContent()
                }
            } label: {
                
                if isExpanded {
                    showOptionalFields()
                    .padding(.bottom, 10)
                } else {
                    showOptionalFields()
                }
            }
            .padding(.trailing, 20)
            Divider()
        }
    }
    
    private func showOptionalFields() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Dates")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 10)
                Spacer()
                if #available(iOS 26.0, *) {
                    Button {
                        toggleOptional.toggle()
                        isExpanded = true
                    } label: {
                        Image(systemName: toggleOptional ? "calendar.badge.minus" : "calendar.badge.plus")
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
    
    @ViewBuilder
    private func toggleOptionalContent() -> some View {
        if toggleOptional {
            VStack {
                Divider()
                DatePicker(
                    "Installation Date",
                    selection: $installationDate,
                    displayedComponents: .date
                )
                .foregroundStyle(AppColors.secondaryText)
                .padding(.horizontal, 15)
                Divider()
                DatePicker(
                    "Service Date",
                    selection: $serviceDate,
                    displayedComponents: .date
                )
                .foregroundStyle(AppColors.secondaryText)
                .padding(.horizontal, 15)
                Divider()
                MultiDatePicker(
                    "Multiple Dates",
                    selection: $customDateRange
                )
                .foregroundStyle(AppColors.secondaryText)
                .padding(.horizontal, 15)
            }
            .padding(.bottom, 1)
        }
    }
    
    private func optionalDateBinding(_ date: Binding<Date?>) -> Binding<Date> {
            Binding(
                get: { date.wrappedValue ?? Date() },
                set: { date.wrappedValue = $0 }
            )
        }
}
