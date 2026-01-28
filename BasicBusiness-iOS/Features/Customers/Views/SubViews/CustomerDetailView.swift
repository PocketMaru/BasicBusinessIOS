import SwiftUI

struct CustomerDetailView: View {
    
    @Bindable var customer: CustomerFormVM
    @Bindable var listVM: CustomerListVM
    @Binding var activeSheet: ActiveUserSheet?
    @State private var isEditing = false
    @State private var attemptedEdit = false
    var body: some View {
        
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 10) {
                    if isEditing {
                        Group {
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.firstNameError,
                                header: "First name"
                            ) {
                                TextField("First name", text: $customer.draft.firstName)
                                    .onChange(of: customer.draft.firstName) { _, _ in
                                            if attemptedEdit {
                                                _ = customer.validateFields()
                                            }
                                        }
                            }
                            .padding(.top, 16)
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.lastNameError,
                                header: "Last name"
                            ) {
                                TextField("Last name", text: $customer.draft.lastName)
                                    .onChange(of: customer.draft.lastName) { _, _ in
                                            if attemptedEdit {
                                                _ = customer.validateFields()
                                            }
                                        }
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.emailError,
                                header: "Email"
                            ) {
                                TextField("Email", text: $customer.draft.email)
                                    .keyboardType(.emailAddress)
                                    .onChange(of: customer.draft.email) { _, _ in
                                            if attemptedEdit {
                                                _ = customer.validateFields()
                                            }
                                        }
                            }
                            .padding(5)
                            CustomFormView(
                                shouldValidate: attemptedEdit,
                                errorMessage: customer.phoneError,
                                header: "Phone number"
                            ) {
                                TextField("Phone", text: $customer.draft.phone)
                                    .onChange(of: customer.draft.phone) { _, _ in
                                            if attemptedEdit {
                                                _ = customer.validateFields()
                                            }
                                        }
                            }
                            .padding(5)
                            CustomFormView(header: "Address") {
                                TextField("Address", text: $customer.draft.address.defaulting(to: ""))
                            }
                            .padding(5)
                            CustomFormView(header: "Zip Code") {
                                TextField("Zip Code", text: $customer.draft.zipCode.defaulting(to: ""))
                            }
                            .padding(5)
                        }
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
                            valueEight: String("\(customer.original.loyaltyDate.formattedMonthDayYear)"),
                            titleNine: nil,
                            valueNine: nil,
                            titleTen: nil,
                            valueTen: nil,
                            titleEleven: nil,
                            valueEleven: nil
                            
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
            primaryIconName: nil,
            editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
            editIconTapped: {
                if isEditing {
                    attemptedEdit = true
                    let success = customer.trySubmit()
                    if success {
                        isEditing = false
                        attemptedEdit = false
                    }
                } else {
                    customer.cancelEdits()
                    isEditing = true
                    attemptedEdit = true
                }
            },
            editIconColor: AppColors.accent
        )
        
    }
}
