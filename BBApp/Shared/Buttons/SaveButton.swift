//
//  SaveQuoteButton.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct SaveButton: View {
    let name: String
    let tapAction: () -> Void
    
    init(
        name: String,
        tapAction: @escaping () -> Void
    ){
        self.name = name
        self.tapAction = tapAction
    }
    var body: some View {
        Button(action: tapAction) {
            Text(name)
                .font(.system(size: 18, weight: .heavy))
                .foregroundStyle(AppColors.accent)
                .frame(width: 250, height: 50)
                .bubbleStyle()
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
        }
    }
}
