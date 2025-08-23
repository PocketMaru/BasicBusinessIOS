//
//  AddCustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/29/25.
//

import SwiftUI

struct AddCustomerView: View {
    @Bindable var customerListVM: CustomerListVM
    @Bindable var newCustomer: CustomerFormVM
    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveUserSheet?
    @State private var attemptedSave: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: newCustomer.firstNameError
                        ) {
                            TextField("First Name", text: $newCustomer.draft.firstName)
                        }
                        .padding(.top,16)
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: newCustomer.lastNameError
                        ) {
                            TextField("Last Name", text: $newCustomer.draft.lastName)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: newCustomer.emailError
                        ) {
                            TextField("Email", text: $newCustomer.draft.email)
                                .keyboardType(.emailAddress)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: newCustomer.phoneError
                        ) {
                            TextField("Phone", text: $newCustomer.draft.phone)
                                .keyboardType(.numberPad)
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Address", text: Binding (
                                get: {newCustomer.draft.address ?? ""},
                                set: {newCustomer.draft.address = $0.isEmpty ? nil : $0}))
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Zip Code", text: Binding(
                                get: {newCustomer.draft.zipCode ?? ""},
                                set: {newCustomer.draft.zipCode = $0.isEmpty ? nil : $0}
                            ))
                        }
                        .padding(5)
                        // TODO: Add syntax to add customer.
                        SaveButton(name: "Add Customer", tapAction: {
                            customerListVM.addCustomer(from: newCustomer.draft)
                            newCustomer.cancelEdits()
                            isPresented.toggle()
                            
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




