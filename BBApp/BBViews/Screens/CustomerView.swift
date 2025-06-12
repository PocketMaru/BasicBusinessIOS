//
//  CustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerView: View {
    @Bindable var customerListVM: CustomerListVM
    @Bindable var customerDetailVM: CustomerDetailVM
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                List {
                    ForEach($customerListVM.allCustomers) { $customer in
                        Text("\(customer.firstName) \(customer.lastName)")
                            .foregroundStyle(AppColors.text)
                            .listRowBackground(AppColors.bg)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ToolBarTitle()
        }
    }
}
