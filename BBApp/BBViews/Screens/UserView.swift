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
            ZStack {
                AppColors.bg.ignoresSafeArea()
                VStack() {
                    Group {
                            Form {
                                Section(header: Text("Business Name")) {
                                   if isEditing {
                                        TextField("Business Name", text: $userVM.user.businessName)
                                    } else {
                                        Text("\(userVM.user.businessName)")
                                    }
                                }
                                Section(header: Text("Owner")) {
                                   if isEditing {
                                       TextField("First Name", text: $userVM.user.firstName)
                                       TextField("Last Name", text: $userVM.user.lastName)
                                    } else {
                                        Text("\(userVM.user.fullName!)")
                                    }
                                }
                                Section(header: Text("Industry")) {
                                    if isEditing {
                                        Picker("Industry", selection: $selectIndustry) {
                                            ForEach(IndustryType.allCases) { type in
                                                Text(type.displayName).tag(type)
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                    } else {
                                        Text("\(selectIndustry.displayName)")
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                            .background(AppColors.bg)
                    }
                }
            }
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

