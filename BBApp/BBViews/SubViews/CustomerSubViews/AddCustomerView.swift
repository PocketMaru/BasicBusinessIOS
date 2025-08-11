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
    @State var draftCustomer = CustomerModel()
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 10) {
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: customerListVM.firstNameError
                        ) {
                            TextField("First Name", text: $draftCustomer.firstName)
                        }
                        .padding(.top,16)
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: customerListVM.lastNameError
                        ) {
                            TextField("Last Name", text: $draftCustomer.lastName)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: customerListVM.emailError
                        ) {
                            TextField("Email", text: $draftCustomer.email)
                                .keyboardType(.emailAddress)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedSave,
                            errorMessage: customerListVM.phoneError
                        ) {
                            TextField("Phone", text: $draftCustomer.phone)
                                .keyboardType(.numberPad)
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Address", text: Binding (
                                get: {draftCustomer.address ?? ""},
                                set: {draftCustomer.address = $0.isEmpty ? nil : $0}))
                        }
                        .padding(5)
                        CustomFormView() {
                            TextField("Zip Code", text: Binding(
                                get: {draftCustomer.zipCode ?? ""},
                                set: {draftCustomer.zipCode = $0.isEmpty ? nil : $0}
                            ))
                        }
                        .padding(5)
                        SaveButton(name: "Add Customer", tapAction: {
                            let didSave = customerListVM.addCustomer(
                                firstName: draftCustomer.firstName,
                                lastName: draftCustomer.lastName,
                                email: draftCustomer.email,
                                address: draftCustomer.address ?? "",
                                zipCode: draftCustomer.zipCode ?? "",
                                phone: draftCustomer.phone,
                                paidBill: draftCustomer.paidBill ?? false
                            )
                            if didSave {
                                draftCustomer = CustomerModel()
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




