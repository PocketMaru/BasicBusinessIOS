//
//  LPToolBarTitle.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/9/25.
//

import SwiftUI




//extension View {
//    func ToolBarTitle(_ title: String = "Basic Business", iconName: String? = "chart.bar") -> some View {
//        self
//            .navigationTitle(title)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                if let icon = iconName {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Image(systemName: icon)
//                            .font(.title3.bold())
//                            .foregroundStyle(AppColors.accent)
//                    }
//                }
//            }
//    }
//}

extension View {
    func ToolBarTitle(_ title: String = "Basic Business", _ iconName: String? = "chart.bar") -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(AppColors.accent.opacity(0.15))
                            .clipShape(Capsule())
                            .foregroundStyle(AppColors.accent)
                }
                ToolbarItem(placement: .topBarLeading) {
                   Image(systemName: "chart.bar")
                        .font(.title3.bold())
                        .foregroundStyle(AppColors.accent)
                }
                
            }
    }
}
