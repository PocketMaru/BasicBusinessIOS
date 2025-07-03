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
    @Binding var customerDetailVM: CustomerDetailVM
    var body: some View {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                List {
                    ForEach(Array(customerListVM.allCustomers.enumerated()), id: \.element.id) { index, customer in
                        NavigationLink(
                            destination:CustomerDetailView(
                                customer: CustomerDetailVM(
                                    customer: customer,
                                    onSave: { updatedCustomer in
                                    customerListVM.updateCustomer(with: updatedCustomer)
                                }),
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
                    .onDelete { IndexSet in
                        for index in IndexSet {
                            customerListVM.removeCustomer(at: index)
                        }
                    }
                }
                .padding(.top, 30)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
            .navigationBarTitleDisplayMode(.inline)
            .ToolBarTitle(
                title: userVM.user?.businessName ?? "",
                editIconName: "plus.circle",
                editButtonColor: activeSheet == nil ? AppColors.accent : AppColors.success,
                mainIconTapped: {
                    if activeSheet == nil {
                        activeSheet = .user
                    }
            }, editIconTapped: {
                customerDetailVM.customer = CustomerModel()
                activeSheet = .addCustomer
            })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
