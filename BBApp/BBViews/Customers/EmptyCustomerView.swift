//
//  LPEmptyCustomerView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/10/25.
//

import SwiftUI

struct EmptyCustomerView: View {
    @Binding var customers: [CustomerModel]
    var body: some View {
        ScrollView {
            Section {
                    Spacer()
                    Text("Add a customer to get started.")
                        .foregroundStyle(.black)
                    Spacer()
            }
        }
    }
}


