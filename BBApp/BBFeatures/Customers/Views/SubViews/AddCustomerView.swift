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
                            TextField("Address", text: $newCustomer.draft.address.defaulting(to: ""))
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Zip Code", text: $newCustomer.draft.zipCode.defaulting(to: ""))
                        }
                        .padding(5)
                        SaveButton(name: "Add Customer", tapAction: {
                            let success = newCustomer.trySubmit()
                            attemptedSave = true
                            if success {
                                attemptedSave = false
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
        .alert("Failed to save customer", isPresented: $newCustomer.showAlert) {
            
        }

    }
    
}




