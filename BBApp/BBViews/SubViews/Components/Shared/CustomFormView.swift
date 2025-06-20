//
//  CustomFormView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/14/25.
//

import SwiftUI

struct CustomFormView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CustomSectionView(headerTitle: "First Name") {
                    TextField("Enter Name", text: .constant(""))
                }
            }
        }
    }
}

