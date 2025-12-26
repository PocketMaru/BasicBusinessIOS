import Foundation

enum FormMode {
    case add
    case edit
}

@MainActor
@Observable
final class CustomerFormVM {
    
    let mode: FormMode
    
    private(set) var original: CustomerModel
    
    var draft: CustomerModel
    
    var firstNameError: String? = nil
    var lastNameError:  String? = nil
    var emailError:     String? = nil
    var phoneError:     String? = nil
    var generalError:   String? = nil
    var showAlert: Bool = false
    private let onSubmit: (CustomerModel) throws -> Void
    
    init(
        customer: CustomerModel,
        mode: FormMode,
        onSubmit: @escaping (CustomerModel) throws -> Void
    ) {
        self.mode = mode
        self.original = customer
        self.draft = customer
        self.onSubmit = onSubmit
    }
    
    func validateFields() -> Bool {
        firstNameError  = draft.firstName.isEmpty ? "Required" : nil
        lastNameError   = draft.lastName.isEmpty  ? "Required" : nil
        emailError      = draft.email.isEmpty     ? "Required" : nil
        phoneError      = draft.phone.isEmpty     ? "Required" : nil
        return [firstNameError, lastNameError, emailError, phoneError].allSatisfy { $0 == nil }
    }
    
    func cancelEdits() {
        draft = original
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        let isValid = validateFields()
        if isValid {
            do {
                try onSubmit(draft)
                return true
            } catch {
                generalError = error.localizedDescription
                showAlert = true
                return false
            }
        } else {
            return false
        }
    }
    
    func clearErrors() {
        firstNameError  = nil
        lastNameError   = nil
        emailError      = nil
        phoneError      = nil
    }
}
