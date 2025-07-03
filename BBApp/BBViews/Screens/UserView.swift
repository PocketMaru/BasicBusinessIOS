//
//  UserView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import SwiftUI

struct UserView: View {
    @Bindable var userVM: UserVM
    
    @Binding var isPresented: Bool
    
    @State private var isEditing = false
    @State private var selectIndustry: IndustryType = .consulting
    @State private var attemptedEdit: Bool = false
    var body: some View {
        
        var isBusinessNameValid: Bool {
            if let businessName = userVM.user?.businessName {
                return !businessName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return false
        }
        
        var isUserFirstNameValid: Bool {
            if let userFirstName = userVM.user?.firstName {
                return !userFirstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return false
        }
        
        var isUserLastNameValid: Bool {
            if let userLastName = userVM.user?.lastName {
                return !userLastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
            return false
        }
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    CustomFormView(
                        shouldValidate: attemptedEdit && !isBusinessNameValid,
                        errorMessage: "Business Name is required",
                        header: "Business name"
                    ) {
                        if isEditing {
                            if let _ = userVM.user {
                                TextField("Business name", text: Binding(
                                    get: {userVM.user?.businessName ?? ""},
                                    set: {userVM.user?.businessName = $0}
                                ))
                            }
                        } else {
                            if let _ = userVM.user {
                                Text("\(userVM.user?.businessName ?? "No Business Name")")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    .padding(.top, 16)
                    .padding(5)
                    
                    if isEditing {
                        CustomFormView(
                            shouldValidate: attemptedEdit && !isUserFirstNameValid,
                            errorMessage: "First Name is required",
                            header: "First name"
                        ) {
                            if let _ = userVM.user {
                                TextField("First name", text:Binding(
                                    get: {userVM.user?.firstName ?? ""},
                                    set: {userVM.user?.firstName = $0}
                                ))
                            }
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedEdit && !isUserLastNameValid,
                            errorMessage: "Last Name is required",
                            header: "Last name"
                        ) {
                            if let _ = userVM.user {
                                TextField("Last name", text:Binding(
                                    get: {userVM.user?.lastName ?? ""},
                                    set: {userVM.user?.lastName = $0}
                                ))
                            }
                        }
                        .padding(5)
                    } else {
                        CustomFormView(header: "Legal Name") {
                            Text("\(userVM.user?.fullName ?? userVM.user?.firstName ?? "No Name")")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(5)
                    }
                    
                    if isEditing {
                        CustomFormView(
                            header: "Industry",
                            fixedHeight: false
                        ) {
                            Picker("Industry", selection: $selectIndustry) {
                                ForEach(IndustryType.allCases) { type in
                                    Text(type.displayName).tag(type)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(maxHeight: 150)
                        }
                    } else {
                        CustomFormView(header: "Industry") {
                            Text("\(selectIndustry.displayName)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(5)
                    }
                }
                .hideKeyboardOnTap()
            }
            .background(AppColors.bg)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ToolBarTitle(
                title:"User Profile",
                iconName: "arrowshape.backward.circle.fill",
                editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                editMode: $isEditing,
                editButtonColor: isEditing ? AppColors.success : AppColors.accent,
                mainIconTapped: {
                    isPresented.toggle()
                }, editIconTapped:  {
                    attemptedEdit = true
                    if !isBusinessNameValid {return}
                    if !isUserFirstNameValid {return}
                    if !isUserLastNameValid {return}
                    isEditing.toggle()
                })
            
        }
    }
}

