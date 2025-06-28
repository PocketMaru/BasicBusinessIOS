//
//  LPToolBarTitle.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/9/25.
//

import SwiftUI
// My version of liquid glass for titles, light and dark mode variants.
extension View {
    func ToolBarTitle(
        title: String = "Basic Business",
        iconName: String? = "chart.bar",
        editIconName: String? = "person.circle.fill",
        editMode: Binding<Bool>? = nil,
        mainIconTapped: (() -> Void)? = nil,
        editIconTapped: (() -> Void)? = nil
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .bubbleStyle()
                }
                if let icon = iconName, !icon.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        if let action = mainIconTapped {
                            Button(action: action) {
                                Image(systemName: icon)
                                    .font(.title3.bold())
                                    .foregroundStyle(AppColors.accent)
                            }
                        }
                        else {
                            Image(systemName: icon)
                                .font(.title3.bold())
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
                if let action = editIconTapped, let editIconName = editIconName {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(systemName: editIconName)
                                .font(.title3.bold())
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
            }
    }
}
