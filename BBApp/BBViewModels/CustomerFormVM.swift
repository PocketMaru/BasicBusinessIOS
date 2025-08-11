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
    
    var draft: CustomerModel {
        didSet {validateLive()}
    }
    
    private(set) var errors: SaveCustomerValidationErrors?
    
    var firstNameError: String? { errors?.firstName}
    var lastNameError: String? { errors?.lastName}
    var emailError: String? { errors?.email}
    var phoneError: String? { errors?.phone}
    var generalError: String? { errors?.generalMessage}
    
    var isDirty: Bool {
        original != draft
    }
    
    init(
        customer: CustomerModel,
        mode: CustomerFormMode,
        saveUseCase: SaveCustomerUseCase,
        setStatusMessage: ((String) -> Void)? = nil
    ) {
        self.mode = mode
        self.original = customer
        self.draft = customer
        self.saveUseCase = saveUseCase
        self.setStatusMessage = setStatusMessage
    }
    
    func cancelEdits() {
        draft = original
        errors = nil
    }
    
    func validateLive() {
        errors = saveUseCase.validateOnly(customer: draft)
    }
    
    @discardableResult
    func saveChanges(successMessage: String) -> Bool {
        switch saveUseCase.execute(customer: draft) {
        case .success:
            original = draft
            errors = nil
            setStatusMessage?(successMessage)
            return true
        case .failure(let validationErrors):
            errors = validationErrors
            return false
        }
    }
}
