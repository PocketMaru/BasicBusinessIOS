//
//  StatBubbleView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import SwiftUI

struct StatButtonView: View {
    let label: String
    let value: String
    let tapAction: () -> Void

    var body: some View {
        Button(action: tapAction) {
            VStack(spacing: 4) {
                Text(value)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(AppColors.secondaryText)
                Text(label)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            .statBubbleStyle()
        }
    }
}

