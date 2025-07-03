//
//  StatButtonBG.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 7/2/25.
//

import SwiftUI

struct StatButtonBG: ViewModifier {
    var backgroundColor: Color = AppColors.secondaryBG

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
            )
    }
}

extension View {
    func statButtonBG(backgroundColor: Color = AppColors.secondaryBG) -> some View {
        self.modifier(StatButtonBG(backgroundColor: backgroundColor))
    }
}
