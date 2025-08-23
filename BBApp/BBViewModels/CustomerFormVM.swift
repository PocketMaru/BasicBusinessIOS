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
        
        didSet {
            if oldValue.equalsForEdit(draft) { return }
            print("draft changed:", draft.firstName, draft.lastName)
            validateLiveAndUpdateErrors()}
    }
    
    private(set) var errors: SaveCustomerValidationErrors?
    
    var firstNameError: String? { errors?.firstName}
    var lastNameError:  String? { errors?.lastName}
    var emailError:     String? { errors?.email}
    var phoneError:     String? { errors?.phone}
    var generalError:   String? { errors?.generalMessage}
    
    var isDirty: Bool {
        !draft.equalsForEdit(original)
    }
    
    private let onSubmit: (CustomerModel) -> Result<Void, SaveCustomerValidationErrors>
    
    init(
        customer: CustomerModel,
        mode: CustomerFormMode,
        saveUseCase: SaveCustomerUseCase,
        setStatusMessage: ((String) -> Void)? = nil,
        onSubmit: @escaping (CustomerModel) -> Result<Void, SaveCustomerValidationErrors>
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
    
    func cancelEdits() {
        draft = original
        errors = nil
        setStatusMessage?("Edit Cancelled")
    }
    
    @discardableResult
    func validateLiveAndUpdateErrors() -> Result<Void, SaveCustomerValidationErrors> {
        let errs = validateCustomerInput(customer: draft)
        if errs.isEmpty {
            errors = nil
            return .success(())
        } else {
            let wrapped = SaveCustomerValidationErrors(errors: errs)
            errors = wrapped
            return .failure(wrapped)
        }
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        let result = onSubmit(draft)
        
        switch result {
        case .success:
            original = draft
            errors = nil
            return true
        case .failure(let e):
            self.errors = e
            return false
        }
    }
}
