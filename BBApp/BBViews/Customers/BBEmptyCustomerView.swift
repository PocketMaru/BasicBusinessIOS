//
//  LPEmptyCustomerView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/10/25.
//

import SwiftUI

struct BBEmptyCustomerView: View {
    @Binding var customers: [BBCustomerModel]
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


