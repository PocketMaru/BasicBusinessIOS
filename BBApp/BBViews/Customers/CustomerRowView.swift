//
//  LPCustomerRowView.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/10/25.
//

import SwiftUI

struct CustomerRowView: View {
    @Binding var customers: [CustomerModel]
    var body: some View {
        List {
            ForEach(customers, id: \.customerID) { customer in
                Text(customer.fullName)
            }
        }
    }
}
