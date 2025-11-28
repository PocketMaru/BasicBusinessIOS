//
//  CustomButtonBG.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 7/2/25.
//

import SwiftUI

struct CustomButtonBG: ViewModifier {
    var backgroundColor: Color = AppColors.buttonColor
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                backgroundColor
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 4)
            )
            .padding(.horizontal)
    }
}

extension View {
    func customButtonBG(backgroundColor: Color = AppColors.secondaryBG) -> some View {
        self.modifier(CustomButtonBG(backgroundColor: backgroundColor))
    }
}
