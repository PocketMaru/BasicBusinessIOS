//
//  CustomerRow.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct CustomerDetailView: View {
    @Bindable var customer: CustomerDetailVM
    @State private var isEditing = false
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.bg.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        CustomFormView(headerTitle: "First Name") {
                            if isEditing {
                                TextField("First Name", text: $customer.customer.firstName)
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.firstName)
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Last Name") {
                            if isEditing {
                                TextField("First Name", text: $customer.customer.lastName)
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.lastName)
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Email") {
                            if isEditing {
                                TextField("Email", text: $customer.customer.email)
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.email)
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Address") {
                            if isEditing {
                                TextField("Address", text: Binding (
                                    get: {customer.customer.address ?? ""},
                                    set: {customer.customer.address = $0.isEmpty ? nil : $0}))
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.address ?? "")
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Phone") {
                            if isEditing {
                                TextField("Phone", text: $customer.customer.phone)
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.phone)
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Zip Code") {
                            if isEditing {
                                TextField("Zip Code", text: Binding(
                                    get: {customer.customer.zipCode ?? ""},
                                    set: {customer.customer.zipCode = $0.isEmpty ? nil : $0}
                                ))
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.zipCode ?? "")
                                    Spacer()
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Paid Status") {
                            if isEditing {
                                Toggle("Paid Status", isOn: Binding(
                                    get: {customer.customer.paidBill ?? false},
                                    set: {customer.customer.paidBill = $0}
                                ))
                            } else {
                                HStack {
                                    Spacer()
                                    Text(customer.customer.paidBill ?? false ? "Paid": "Unpaid")
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .background(AppColors.bg)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                        if !isEditing {
                            customer.saveChanges()
                        }
                    }
                }
            }
            .ToolBarTitle(title: customer.customer.firstName + " " + customer.customer.lastName, mainIconTapped: {
                activeSheet = .user
            })
        }
    }
}
