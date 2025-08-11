//
//  CustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerListView: View {
    var customerListVM: CustomerListVM
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                List {
                    ForEach(customerListVM.allCustomers, id: \.id) { customer in
                        NavigationLink(
                            destination:CustomerDetailView(
                                customer: configuredDetailVM(for: customer),
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
                    .onDelete { indexSet in
                        for index in indexSet{
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
                activeSheet = .addCustomer
            })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func configuredDetailVM(for customer: CustomerModel) -> CustomerFormVM {
        let useCase = SaveCustomerInteractor(fileStorage: FileStorageManager())
        return CustomerFormVM(customer: customer, saveUseCase: useCase )
    }
}
