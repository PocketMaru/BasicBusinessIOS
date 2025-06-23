//
//  CustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerView: View {
    @Bindable var customerListVM: CustomerListVM
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                List {
                    ForEach(customerListVM.allCustomers) { customer in
                        NavigationLink(
                            destination:CustomerDetailView(
                                customer: CustomerDetailVM(
                                    customer: customer),
                                userVM: userVM,
                                activeSheet: $activeSheet
                            )) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .foregroundColor(AppColors.accent)
                                    .frame(width: 32, height: 32)
                                    .padding(.leading, 8)
                                Text("\(customer.firstName) \(customer.lastName)")
                                    .foregroundStyle(AppColors.text)
                                
                            }
                        }
                        .listRowBackground(AppColors.bg)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ToolBarTitle(title: userVM.user.businessName, mainIconTapped: {
                activeSheet = .user
            })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
