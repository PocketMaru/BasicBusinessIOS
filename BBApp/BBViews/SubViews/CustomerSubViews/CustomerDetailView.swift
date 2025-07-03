//
//  CustomerRow.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @Bindable var customer: CustomerDetailVM
    @Bindable var userVM: UserVM
    
    @Binding var activeSheet: ActiveUserSheet?
    @State private var isEditing = false
    @State private var attemptedEdit = false
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
                            shouldValidate: attemptedEdit && !isFirstNameValid,
                            errorMessage: "First name is required",
                            header: "First name"
                        ) {
                            if isEditing {
                                TextField("First name", text: $customer.customer.firstName)
                            } else {
                                Text(customer.customer.firstName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.top, 16)
                        .padding(5)
                        
                        CustomFormView(
                            shouldValidate: attemptedEdit && !isLastNameValid,
                            errorMessage: "Last name is required",
                            header: "Last name"
                        ) {
                            if isEditing {
                                TextField("Last name", text: $customer.customer.lastName)
                            } else {
                                Text(customer.customer.lastName)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                        
                        CustomFormView(
                            shouldValidate: attemptedEdit && !isEmailValid,
                            errorMessage: "Email is required",
                            header: "Email"
                        ) {
                            if isEditing {
                                TextField("Email", text: $customer.customer.email)
                                    .keyboardType(.emailAddress)
                            } else {
                                Text(customer.customer.email)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                        
                        CustomFormView(
                            shouldValidate: attemptedEdit && !isPhoneValid,
                            errorMessage: "Phone number is required",
                            header: "Phone number"
                        ) {
                            if isEditing {
                                TextField("Phone", text: $customer.customer.phone)
                            } else {
                                Text(customer.customer.phone)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                        
                        CustomFormView(header: "Address") {
                            if isEditing {
                                TextField("Address", text: Binding (
                                    get: {customer.customer.address ?? ""},
                                    set: {customer.customer.address = $0.isEmpty ? nil : $0}))
                            } else {
                                Text(customer.customer.address ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                        
                        CustomFormView(header: "Zip Code") {
                            if isEditing {
                                TextField("Zip Code", text: Binding(
                                    get: {customer.customer.zipCode ?? ""},
                                    set: {customer.customer.zipCode = $0.isEmpty ? nil : $0}
                                ))
                            } else {
                                Text(customer.customer.zipCode ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                        
                        CustomFormView(header: "Paid Status") {
                            if isEditing {
                                Toggle("Paid Status", isOn: Binding(
                                    get: {customer.customer.paidBill ?? false},
                                    set: {customer.customer.paidBill = $0}
                                ))
                            } else {
                                Text(customer.customer.paidBill ?? false ? "Paid": "Unpaid")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(5)
                    }
                    .hideKeyboardOnTap()
                }
            }
            .background(
                AppColors.bg)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ToolBarTitle(
                title: customer.customer.firstName + " " + customer.customer.lastName,
                iconName: nil,
                editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                editButtonColor: isEditing ? AppColors.success : AppColors.accent,
                editIconTapped: {
                    attemptedEdit = true
                    if !isFirstNameValid {return}
                    if !isLastNameValid {return}
                    if !isEmailValid {return}
                    if !isPhoneValid {return}
                    isEditing.toggle()
                    customer.saveChanges()
                })
        }
    }
}
