import SwiftUI

struct CustomFieldFormSection: View {
    @Binding var customField: CustomField
    @FocusState private var focusedField: Bool
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Label", text: $customField.label)
                .focused($focusedField)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .foregroundStyle(AppColors.secondaryText)
            Divider()
            TextField("Value", value: $customField.value, format: .currency(code: "USD")
            )
            .focused($focusedField)
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .foregroundStyle(AppColors.secondaryText)
        }
        .statBubbleStyle()
        .statButtonBG(emphasis: .subtle)
        .padding(.horizontal, 15)
    }
}
