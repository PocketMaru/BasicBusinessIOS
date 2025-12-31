import SwiftUI

struct NoteSection: View {
    @Binding var notes: String
    @FocusState var isFocused: Bool
    
    let isVisible: Bool
    var body: some View {
        if isVisible {
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                TextField("Notes", text: $notes, axis: .vertical)
                    .focused($isFocused)
                    .lineLimit(3...10)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .statBubbleStyle()
                    .statButtonBG(emphasis: .subtle)
                    .foregroundStyle(AppColors.secondaryText)
            }
            .padding(.horizontal, 15)
        }
    }
}
