import SwiftUI

struct DGButtonStyle: View {
    let action: () -> Void
    var image: String
    var isExpanded: Binding<Bool>
    var toggleState: Binding<Bool>
    let isToggleButton: Bool
    var body: some View {
        Button {
            if isToggleButton {
                action()
                isExpanded.wrappedValue = true
            } else {
                action()
                isExpanded.wrappedValue = true
            }
            
        } label: {
            if #available(iOS 26.0, *) {
                Image(systemName: image)
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
