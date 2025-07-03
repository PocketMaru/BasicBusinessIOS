//
//  AddCustomerView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/29/25.
//

import SwiftUI

struct AddCustomerView: View {
    @Bindable var customer: CustomerDetailVM
    @Bindable var customerVM: CustomerListVM
    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveUserSheet?
    @State private var attemptedSave: Bool = false
    
    var body: some View {
        var isFirstNameValid: Bool { !customer.customer.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
        var isLastNameValid: Bool { !customer.customer.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
        var isEmailValid: Bool { !customer.customer.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
        var isPhoneValid: Bool { !customer.customer.phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty}
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        CustomFormView(
                            shouldValidate: attemptedSave && !isFirstNameValid,
                            errorMessage: "First name is required"
                        ) {
                            TextField("First Name", text: $customer.customer.firstName)
                        }
                        .padding(.top,16)
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave && !isLastNameValid,
                            errorMessage: "Last name is required"
                        ) {
                            TextField("Last Name", text: $customer.customer.lastName)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave && !isEmailValid,
                            errorMessage: "Email is required"
                        ) {
                            TextField("Email", text: $customer.customer.email)
                            .keyboardType(.emailAddress)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave && !isPhoneValid,
                            errorMessage: "Phone number is required"
                        ) {
                            TextField("Phone", text: $customer.customer.phone)
                            .keyboardType(.numberPad)
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Address", text: Binding (
                                get: {customer.customer.address ?? ""},
                                set: {customer.customer.address = $0.isEmpty ? nil : $0}))
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Zip Code", text: Binding(
                                get: {customer.customer.zipCode ?? ""},
                                set: {customer.customer.zipCode = $0.isEmpty ? nil : $0}
                            ))
                        }
                        .padding(5)
                        SaveButton(name: "Add Customer", tapAction: {
                            attemptedSave = true
                            if !isFirstNameValid {return}
                            if !isLastNameValid {return}
                            if !isEmailValid {return}
                            if !isPhoneValid {return}
                            customerVM.addCustomer(
                                firstName: customer.customer.firstName,
                                lastName: customer.customer.lastName,
                                email: customer.customer.email,
                                address: customer.customer.address ?? "",
                                zipCode: customer.customer.zipCode ?? "",
                                phone: customer.customer.phone,
                                paidBill: customer.customer.paidBill ?? false
                            )
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

    


