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
                        if isEditing {
                            CustomFormView(
                                shouldValidate: attemptedEdit && !isFirstNameValid,
                                errorMessage: "First name is required",
                                header: "First name"
                            ) {
                                TextField("First name", text: $customer.customer.firstName)
                            }
                            .padding(.top, 16)
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit && !isLastNameValid,
                                errorMessage: "Last name is required",
                                header: "Last name"
                            ) {
                                TextField("Last name", text: $customer.customer.lastName)
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit && !isEmailValid,
                                errorMessage: "Email is required",
                                header: "Email"
                            ) {
                                TextField("Email", text: $customer.customer.email)
                                    .keyboardType(.emailAddress)
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit && !isPhoneValid,
                                errorMessage: "Phone number is required",
                                header: "Phone number"
                            ) {
                                TextField("Phone", text: $customer.customer.phone)
                            }
                            .padding(5)
                            CustomFormView(header: "Address") {
                                TextField("Address", text: Binding (
                                    get: {customer.customer.address ?? ""},
                                    set: {customer.customer.address = $0.isEmpty ? nil : $0}))
                            }
                            .padding(5)
                            CustomFormView(header: "Zip Code") {
                                TextField("Zip Code", text: Binding(
                                    get: {customer.customer.zipCode ?? ""},
                                    set: {customer.customer.zipCode = $0.isEmpty ? nil : $0}
                                ))
                            }
                            .padding(5)
                            CustomFormView(header: "Paid Status") {
                                Toggle("Paid Status", isOn: Binding(
                                    get: {customer.customer.paidBill ?? false},
                                    set: {customer.customer.paidBill = $0}
                                ))
                            }
                            .padding(5)
                            
                        } else {
                            CustomMultiForm(
                                titleOne: "First name",
                                valueOne: customer.customer.firstName,
                                titleTwo: "Last name",
                                valueTwo: customer.customer.lastName,
                                titleThree: "Email",
                                valueThree: customer.customer.email,
                                titleFour: "Phone",
                                valueFour: customer.customer.phone,
                                titleFive: "Address",
                                valueFive: customer.customer.address ?? "",
                                titleSix: "Zip Code",
                                valueSix: customer.customer.zipCode ?? "",
                                titleSeven: "Status",
                                valueSeven: customer.customer.paidBill ?? false ? "Paid": "Unpaid"
                            )
                            .padding(.top, 16)
                        }
                    }
                    .padding(.horizontal, 16)
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
