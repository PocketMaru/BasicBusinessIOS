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
    let applyNetTerms: (Int) -> Void
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
        }
    }
    
    private func showOptionalFields() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dates")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 10)
                Spacer()
                netDateButtons()
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
    
    private func netDateButtons() -> some View {
        HStack {
            if #available(iOS 26.0, *) {

                DGButtonStyle(
                    action: {
                        applyNetTerms(10)
                    },
                    image: "10.calendar",
                    isExpanded: $isExpanded,
                    toggleState: $toggleOptional,
                    isToggleButton: false
                )
                DGButtonStyle(
                    action: {
                        applyNetTerms(15)
                    },
                    image: "15.calendar",
                    isExpanded: $isExpanded,
                    toggleState: $toggleOptional,
                    isToggleButton: false
                )
                DGButtonStyle(
                    action: {
                        applyNetTerms(30)
                    },
                    image: "30.calendar",
                    isExpanded: $isExpanded,
                    toggleState: $toggleOptional,
                    isToggleButton: false
                )
                DGButtonStyle(
                    action: {
                        toggleOptional.toggle()
                    },
                    image: toggleOptional ? "calendar.badge.minus" : "calendar.badge.plus",
                    isExpanded: $isExpanded,
                    toggleState: $toggleOptional,
                    isToggleButton: true
                )
            }
        }
    }
}
