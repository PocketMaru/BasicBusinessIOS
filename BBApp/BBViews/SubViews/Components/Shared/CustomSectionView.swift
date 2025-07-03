//
//  CustomSectionView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/9/25.
//

import SwiftUI

struct CustomSectionView<Content: View>: View {
    
    let headerTitle: String
    let content: Content
    let tapped: (() -> Void)?
    
    init(
        headerTitle: String,
        @ViewBuilder content: () -> Content,
        tapped: (() -> Void)? = nil
    ) {
        self.headerTitle = headerTitle
        self.content = content()
        self.tapped = tapped
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Group {
                if let tapped = tapped {
                    Button(action: tapped) {
                        VStack(spacing: 4) {
                            CustomHeader(title: headerTitle)
                            content
                                .bubbleStyle()
                                .padding(.horizontal, 8)
                        }
                    }
                } else {
                    VStack(spacing: 4) {
                        CustomHeader(title: headerTitle)
                        content
                            .bubbleStyle()
                            .padding(.horizontal, 8)
                    }
                }
            
          }
        }
        .padding(.vertical, 8)
    }
}

struct CustomHeader: View {
    var title: String
    var icon: String? = nil
    var body: some View {
        HStack(spacing: 6) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundStyle(AppColors.secondaryText)
            }
            Text(title)
                .font(.headline)
                .foregroundStyle(AppColors.accent)
        }
    }
}
