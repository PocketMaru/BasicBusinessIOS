//
//  CustomFormView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/14/25.
//

import SwiftUI

struct CustomFormView<Content: View>: View {
    
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
        VStack(alignment: .leading, spacing: 4) {
            Group {
                if let tapped = tapped {
                    Button(action: tapped) {
                        VStack(alignment: .leading, spacing: 4) {
                            CustomFormHeader(title: headerTitle)
                            content
                                .bubbleStyleBLKText()
                                .padding(.horizontal, 2)
                        }
                    }
                } else {
                    VStack(alignment: .leading, spacing: 4) {
                        CustomFormHeader(title: headerTitle)
                        content
                            .bubbleStyleBLKText()
                            .padding(.horizontal, 2)
                    }
                }
            }
        }
    }
}

struct CustomFormHeader: View {
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
        .padding(.horizontal)
    }
}

