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
        editMode: Binding<Bool>? = nil,
        mainIconTapped: (() -> Void)? = nil,
        editIconTapped: (() -> Void)? = nil
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Group {
                        Text(title)
                            .bubbleStyle()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    if let icon = iconName {
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
                
                ToolbarItem(placement: .topBarTrailing) {
                        if let action = editIconTapped {
                            Button(action: action) {
                                if let editField = editMode {
                                    Image(systemName: editField.wrappedValue ? "checkmark.circle.fill" : "pencil.circle" )
                                        .font(.title3.bold())
                                        .foregroundStyle(AppColors.accent)
                                }

                            }
                        }
                }
            }
    }
}
