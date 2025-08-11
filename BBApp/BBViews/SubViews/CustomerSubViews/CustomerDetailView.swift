//
//  CustomerRow.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerDetailView: View {
    
    @Bindable var customer: CustomerDetailVM
    @Binding var activeSheet: ActiveUserSheet?
    @State private var isEditing = false
    @State private var attemptedEdit = false
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        if isEditing {
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.firstNameError,
                                header: "First name"
                            ) {
                                TextField("First name", text: $customer.draft.firstName)
                            }
                            .padding(.top, 16)
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.lastNameError,
                                header: "Last name"
                            ) {
                                TextField("Last name", text: $customer.draft.lastName)
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.emailError,
                                header: "Email"
                            ) {
                                TextField("Email", text: $customer.draft.email)
                                    .keyboardType(.emailAddress)
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.phoneError,
                                header: "Phone number"
                            ) {
                                TextField("Phone", text: $customer.draft.phone)
                            }
                            .padding(5)
                            CustomFormView(header: "Address") {
                                TextField("Address", text: Binding (
                                    get: {customer.draft.address ?? ""},
                                    set: {customer.draft.address = $0.isEmpty ? nil : $0}))
                            }
                            .padding(5)
                            CustomFormView(header: "Zip Code") {
                                TextField("Zip Code", text: Binding(
                                    get: {customer.draft.zipCode ?? ""},
                                    set: {customer.draft.zipCode = $0.isEmpty ? nil : $0}
                                ))
                            }
                            .padding(5)
                            CustomFormView(header: "Paid Status") {
                                Toggle("Paid Status", isOn: Binding(
                                    get: {customer.draft.paidBill ?? false},
                                    set: {customer.draft.paidBill = $0}
                                ))
                            }
                            .padding(5)
                            
                        } else {
                            CustomMultiForm(
                                titleOne: "First name",
                                valueOne: customer.original.firstName,
                                titleTwo: "Last name",
                                valueTwo: customer.original.lastName,
                                titleThree: "Email",
                                valueThree: customer.original.email,
                                titleFour: "Phone",
                                valueFour: customer.original.phone,
                                titleFive: "Address",
                                valueFive: customer.original.address ?? "",
                                titleSix: "Zip Code",
                                valueSix: customer.original.zipCode ?? "",
                                titleSeven: "Status",
                                valueSeven: customer.original.paidBill ?? false ? "Paid": "Unpaid",
                                titleEight: "Loyalty Date",
                                valueEight: String("\(customer.original.loyaltyDate)")
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
                title: customer.draft.firstName + " " + customer.draft.lastName,
                iconName: nil,
                editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                editButtonColor: isEditing ? AppColors.success : AppColors.accent,
                editIconTapped: {
                    if isEditing {
                        attemptedEdit = true
                        
                        if customer.saveChanges(successMessage: "Customer Updated") {
                            isEditing = false
                            attemptedEdit = false
                        }
                    } else {
                        customer.cancelEdits()
                        isEditing = true
                        attemptedEdit = false
                    }
                })
        }
    }
}
