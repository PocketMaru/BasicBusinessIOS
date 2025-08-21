//
//  AddCustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/29/25.
//

import SwiftUI

struct AddCustomerView: View {
    @Bindable var customerListVM: CustomerListVM
    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveUserSheet?
    @State private var attemptedSave: Bool = false
    @State private var vm = CustomerFormVM(
        customer: CustomerModel(),
        mode: .add,
        saveUseCase: SaveCustomer(fileStorage: FileStorageManager())
    )
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: vm.firstNameError
                        ) {
                            TextField("First Name", text: $vm.draft.firstName)
                        }
                        .padding(.top,16)
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: vm.lastNameError
                        ) {
                            TextField("Last Name", text: $vm.draft.lastName)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: vm.emailError
                        ) {
                            TextField("Email", text: $vm.draft.email)
                                .keyboardType(.emailAddress)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: vm.phoneError
                        ) {
                            TextField("Phone", text: $vm.draft.phone)
                                .keyboardType(.numberPad)
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Address", text: Binding (
                                get: {vm.draft.address ?? ""},
                                set: {vm.draft.address = $0.isEmpty ? nil : $0}))
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Zip Code", text: Binding(
                                get: {vm.draft.zipCode ?? ""},
                                set: {vm.draft.zipCode = $0.isEmpty ? nil : $0}
                            ))
                        }
                        .padding(5)
                        SaveButton(name: "Add Customer", tapAction: {
                            let didSave = customerListVM.addCustomer(
                                firstName: vm.draft.firstName,
                                lastName: vm.draft.lastName,
                                email: vm.draft.email,
                                address: vm.draft.address ?? "",
                                zipCode: vm.draft.zipCode ?? "",
                                phone: vm.draft.phone,
                                paidBill: vm.draft.paidBill ?? false
                            )
                            if didSave {
                                vm.cancelEdits()
                                isPresented.toggle()
                            }
                        })
                    }
                    .hideKeyboardOnTap()
                }
            }
            .background(AppColors.bg)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ToolBarTitle(title: "Add Customer", iconName: "arrowshape.backward.circle.fill", mainIconTapped: {
                isPresented.toggle()
            })
        }
    }
    
}




