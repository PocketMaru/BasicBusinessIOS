import SwiftUI

struct UserView: View {
    @Bindable var userVM: UserVM
    
    @Binding var isPresented: Bool
    @Bindable var quoteListVM: QuoteListVM
    @State private var isEditing = false
    @State private var selectIndustry: IndustryChoice = IndustryChoice.all.first!
    @State private var attemptedEdit: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    CustomFormView(
                        shouldValidate: attemptedEdit,
                        errorMessage: "Business Name is required",
                        header: "Business name"
                    ) {
                        if isEditing {
                            TextField("Business name", text: $userVM.user.businessName)
                        } else {
                            Text("\(userVM.user.businessName)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 16)
                    .padding(5)
                    
                    if isEditing {
                        CustomFormView(
                            shouldValidate: attemptedEdit,
                            errorMessage: "First Name is required",
                            header: "First name"
                        ) {
                            TextField("First name", text:$userVM.user.firstName)
                        }
                        .padding(5)
                        CustomFormView(
                            shouldValidate: attemptedEdit,
                            errorMessage: "Last Name is required",
                            header: "Last name"
                        ) {
                            TextField("Last name", text: $userVM.user.lastName)
                        }
                        .padding(5)
                    } else {
                        CustomFormView(header: "Legal Name") {
                            Text("\(userVM.user.fullName)")
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
                                ForEach(IndustryChoice.all) { choice in
                                    Text(choice.displayName).tag(choice)
                                }
                            }
                            .onChange(of: selectIndustry) { newValue, _ in
                                userVM.user.industryType = newValue.type
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
                businessName:"User Profile",
                primaryIconName: "arrowshape.backward.circle.fill",
                primaryIconTapped: {
                    isPresented.toggle()
                }, secondIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                toggleSecondIconState: $isEditing,
                secondButtonColor: isEditing ? AppColors.success : AppColors.accent,
                secondIconTapped:  {
                    attemptedEdit = true
                    isEditing.toggle()
                })
            
        }
    }
}

