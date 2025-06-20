//
//  CapsuleTextFieldStyle.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/14/25.
//

import SwiftUI

struct StatBubbleStyle: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                content
                    .frame(width: 180, height: 120) 
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1)
                    )
            } else {
                content
                    .frame(width: 180, height: 120)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.white.opacity(0.9), lineWidth: 1.5)
                            )
                            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            .shadow(color: Color.white.opacity(0.25), radius: 8, x: 0, y: 0)
                    )
            }
        }
    }
}

extension View {
    func statBubbleStyle() -> some View {
        self.modifier(StatBubbleStyle())
    }
}


