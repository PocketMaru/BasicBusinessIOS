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
                                    Text(customer.customer.firstName)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Last Name") {
                            if isEditing {
                                TextField("First Name", text: $customer.customer.lastName)
                            } else {
                                HStack {
                                    Text(customer.customer.lastName)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        
                        CustomFormView(headerTitle: "Email") {
                            if isEditing {
                                TextField("Email", text: $customer.customer.email)
                            } else {
                                
                                    Text(customer.customer.email)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                
                            }
                        }
                        
                        CustomFormView(headerTitle: "Address") {
                            if isEditing {
                                TextField("Address", text: Binding (
                                    get: {customer.customer.address ?? ""},
                                    set: {customer.customer.address = $0.isEmpty ? nil : $0}))
                            } else {
                               
                                    Text(customer.customer.address ?? "")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                
                            }
                        }
                        
                        CustomFormView(headerTitle: "Phone") {
                            if isEditing {
                                TextField("Phone", text: $customer.customer.phone)
                            } else {
                                    Text(customer.customer.phone)
                                        .frame(maxWidth: .infinity, alignment: .center)
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
            .ToolBarTitle(
                title: customer.customer.firstName + " " + customer.customer.lastName,
                editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                mainIconTapped: {
                activeSheet = .user
            }, editIconTapped: {
                isEditing.toggle()
                if !isEditing {
                    customer.saveChanges()
                }
            })
        }
    }
}
