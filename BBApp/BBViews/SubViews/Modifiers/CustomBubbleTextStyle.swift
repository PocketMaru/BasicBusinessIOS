//
//  CustomBubbleTextStyle.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/19/25.
//

import SwiftUI

struct CustomBubbleTextStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        if colorScheme == .dark {
            content
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
                .foregroundStyle(AppColors.secondaryText)
        } else {
            content
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.white)
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.9), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        .shadow(color: Color.white.opacity(0.25), radius: 8, x: 0, y: 0)
                )
                .foregroundStyle(AppColors.secondaryText)
        }
    }
}

extension View {
    func bubbleStyleBLKText() -> some View {
        self.modifier(CustomBubbleTextStyle())
    }
}
