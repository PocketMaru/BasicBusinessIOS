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
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    CustomFormView(headerTitle: "Business") {
                        if isEditing {
                            TextField("Business Name", text: $userVM.user.businessName)
                        } else {
                            HStack {
                                Spacer()
                                Text("\(userVM.user.businessName)")
                                Spacer()
                            }
                        }
                    }
                    CustomFormView(headerTitle: "Owner") {
                        if isEditing {
                            TextField("First Name", text: $userVM.user.firstName)
                            TextField("Last Name", text: $userVM.user.lastName)
                        } else {
                            HStack {
                                Spacer()
                                Text("\(userVM.user.fullName!)")
                                Spacer()
                            }
                        }
                    }
                    CustomFormView(headerTitle: "Industry") {
                        if isEditing {
                            Picker("Industry", selection: $selectIndustry) {
                                ForEach(IndustryType.allCases) { type in
                                    Text(type.displayName).tag(type)
                                }
                            }
                            .pickerStyle(.wheel)
                        } else {
                            HStack {
                                Spacer()
                                Text("\(selectIndustry.displayName)")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .background(AppColors.bg)
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ToolBarTitle(
                title:"User Profile",
                iconName: "arrowshape.backward.circle.fill",
                editMode: $isEditing,
                mainIconTapped: {
                    isPresented.toggle()
                }, editIconTapped:  {
                    isEditing.toggle()
                })
            
        }
    }
}

