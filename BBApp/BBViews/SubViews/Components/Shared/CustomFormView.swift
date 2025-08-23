//
//  CustomFormView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/14/25.
//

import SwiftUI

struct CustomFormView<Content: View>: View {
    let shouldValidate: Bool
    let errorMessage: String?
    let header: String?
    let fixedHeight: Bool
    let text: String?
    let content: () -> Content
    let tapped: (() -> Void)?
    
    init(
        shouldValidate: Bool = true,
        errorMessage: String? = nil,
        header: String? = nil,
        fixedHeight: Bool = true,
        text: String? = nil,
        @ViewBuilder content: @escaping () -> Content,
        tapped: (() -> Void)? = nil
    ) {
        self.shouldValidate = shouldValidate
        self.errorMessage = errorMessage
        self.header = header
        self.fixedHeight = fixedHeight
        self.text = text
        self.content = content
        self.tapped = tapped
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let header = header {
                CustomHeader(title: header)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            if let tapped = tapped {
                Button(action: tapped) {
                    formFieldContent()
                }
            } else {
                formFieldContent()
            }
        }
    }
    
    @ViewBuilder
    private func formFieldContent() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content()
                .if(fixedHeight) { view in
                    view.frame(height: 48)
                }
                .bubbleStyle()
                .padding(.horizontal, 2)
            if shouldValidate, let errorMessage {
                Text(errorMessage)
                    .foregroundColor(AppColors.error)
                    .padding(.horizontal, 3)
            }
        }
        .padding(.horizontal, 20)
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
    
}
