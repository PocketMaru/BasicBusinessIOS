//
//  CustomerDetailVM.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/11/25.
//

import Foundation

@MainActor
@Observable
final class CustomerDetailVM {
    
    private let saveUseCase: SaveCustomerUseCase
    
    private let setStatusMessage: ((String) -> Void)?
    
    private(set) var original: CustomerModel
    var draft: CustomerModel
    
    private(set) var errors: SaveCustomerValidationErrors?
    
    var firstNameError: String? { errors?.firstName}
    var lastNameError: String? { errors?.lastName}
    var emailError: String? { errors?.email}
    var phoneError: String? { errors?.phone}
    var generalError: String? { errors?.generalMessage}
    
    init(
        customer: CustomerModel,
        saveUseCase: SaveCustomerUseCase,
        setStatusMessage: ((String) -> Void)? = nil
    ) {
        self.original = customer
        self.draft = customer
        self.saveUseCase = saveUseCase
        self.setStatusMessage = setStatusMessage
    }
    
    func cancelEdits() {
        draft = original
        errors = nil
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
