//
//  CustomerDetailVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/11/25.
//

import Foundation

enum CustomerFormMode {
    case add
    case edit
}

@MainActor
@Observable
final class CustomerFormVM {
    
    let mode: CustomerFormMode
    private let saveUseCase: SaveCustomerUseCase
    private let setStatusMessage: ((String) -> Void)?
    
    private(set) var original: CustomerModel
    
    var draft: CustomerModel
    
    var firstNameError: String? = nil
    var lastNameError:  String? = nil
    var emailError:     String? = nil
    var phoneError:     String? = nil
    var generalError:   String? = nil
    
    private let onSubmit: (CustomerModel) -> Void
    
    init(
        customer: CustomerModel,
        mode: CustomerFormMode,
        saveUseCase: SaveCustomerUseCase,
        setStatusMessage: ((String) -> Void)? = nil,
        onSubmit: @escaping (CustomerModel) -> Void
    ) {
        self.mode = mode
        self.original = customer
        self.draft = customer
        self.saveUseCase = saveUseCase
        self.setStatusMessage = setStatusMessage
        self.onSubmit = onSubmit
        print("FormVM INIT id=\(customer.id) name=\(customer.firstName) \(customer.lastName)")
    }
    
    deinit { print("FormVM DEINIT") }
    
    func validateFields() -> Bool {
        firstNameError  = draft.firstName.isEmpty ? "Required" : nil
        lastNameError   = draft.lastName.isEmpty  ? "Required" : nil
        emailError      = draft.email.isEmpty     ? "Required" : nil
        phoneError      = draft.phone.isEmpty     ? "Required" : nil
        return [firstNameError, lastNameError, emailError, phoneError].allSatisfy { $0 == nil }
    }
    
    func cancelEdits() {
        draft = original
        setStatusMessage?("Edit Cancelled")
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        let isValid = validateFields()
        if isValid {
            onSubmit(draft)
            return true
        } else {
            setStatusMessage?("Please correct the errors in the form")
            return false
        }
    }
}
