import Foundation
import Observation

@MainActor
@Observable
final class DocumentMaterialFormVM {
    
    let mode: FormMode
    
    private(set) var original: DocumentMaterialModel
    var draft: DocumentMaterialModel
    
    private let onSubmit: (DocumentMaterialModel) throws -> Void

    var generalError: String? = nil
    var showAlert: Bool = false
    
    init(
        material: DocumentMaterialModel,
        mode: FormMode,
        onSubmit: @escaping (DocumentMaterialModel) throws -> Void
    ) {
        self.original = material
        self.draft = material
        self.mode = mode
        self.onSubmit = onSubmit
    }
    
    func cancelEdits() {
        draft = original
    }
    
    func clearErrors() {
        generalError = nil
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        do {
            try onSubmit(draft)
            return true
        } catch {
            generalError = error.localizedDescription
            showAlert = true
            return false
        }
    }
}
