import SwiftUI

enum SurfaceEmphasis {
    case subtle
    case raised
}

struct StatButtonBG: ViewModifier {
    var backgroundColor: Color = AppColors.secondaryBG
    var emphasis: SurfaceEmphasis = .raised
    var isVisible: Bool = true

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(backgroundColor)
                    .opacity(isVisible ? opacity : 0)
                    .shadow(
                        color: .black.opacity(shadowOpacity),
                        radius: shadowRadius,
                        y: shadowYOffset
                    )
            )
    }

    private var opacity: Double {
        switch emphasis {
        case .subtle: return 0.6
        case .raised: return 1.0
        }
    }

    private var shadowOpacity: Double {
        switch emphasis {
        case .subtle: return 0.05
        case .raised: return 0.12
        }
    }

    private var shadowRadius: CGFloat {
        emphasis == .subtle ? 2 : 4
    }

    private var shadowYOffset: CGFloat {
        emphasis == .subtle ? 1 : 2
    }
}

extension View {
    func statButtonBG(
        emphasis: SurfaceEmphasis = .raised,
        isVisible: Bool = true,
        backgroundColor: Color = AppColors.secondaryBG
    ) -> some View {
        modifier(
            StatButtonBG(
                backgroundColor: backgroundColor,
                emphasis: emphasis,
                isVisible: isVisible
            )
        )
    }
}
