import SwiftUI

struct StatButtonBG: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color = AppColors.secondaryBG
    var isVisible: Bool?

    func body(content: Content) -> some View {
        let shouldShow = (isVisible ?? true) && colorScheme != .dark

        content
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(backgroundColor)
                    .opacity(shouldShow ? 1.0 : 0.0)
                    .shadow(
                        color: .black.opacity(shouldShow ? 0.12 : 0.0),
                        radius: 4,
                        y: 2
                    )
            )
    }
}

extension View {
    func statButtonBG(
        isVisible: Bool? = nil,
        backgroundColor: Color = AppColors.secondaryBG
    ) -> some View {
        self.modifier(
            StatButtonBG(
                backgroundColor: backgroundColor,
                isVisible: isVisible
            )
        )
    }
}
