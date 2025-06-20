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
                Form {
                    Section(header: Text("First Name")) {
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
                    
                    Section(header: Text("Last Name")) {
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
                    
                    Section(header: Text("Email")) {
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
                    
                    Section(header: Text("Address")) {
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
                
                    Section(header: Text("Phone")) {
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
                    
                    Section(header: Text("Zip Code")) {
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
                    
                    Section(header: Text("Paid Status")) {
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
                .scrollContentBackground(.hidden)
                .background(AppColors.bg)
            }
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
            .ToolBarTitle(title: customer.customer.firstName + " " + customer.customer.lastName)
        }
    }
}
