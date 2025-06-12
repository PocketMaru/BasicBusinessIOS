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
    
    init(headerTitle: String, @ViewBuilder content: () -> Content) {
        self.headerTitle = headerTitle
        self.content = content()
    }
    
    var body: some View {
        Section(header: CustomHeader(title: headerTitle)) {
            HStack {
                Spacer()
                content
                Spacer()
            }
        }
    }
}

struct CustomHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: "gear")
                .foregroundStyle(AppColors.text)
            Text(title)
                .foregroundStyle(.black)
        }
    }
}
