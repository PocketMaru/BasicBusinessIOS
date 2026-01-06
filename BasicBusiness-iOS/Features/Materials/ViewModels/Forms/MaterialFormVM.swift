import Foundation
import Observation

@MainActor
@Observable
final class MaterialFormVM {
    
    let mode: FormMode
    
    private(set) var original: MaterialModel
    var draft: MaterialModel
    
    private let onSubmit: (MaterialModel) throws -> Void
    
    var nameError: String? = nil
    var unitCostError: String? = nil
    var generalError: String? = nil
    var showAlert: Bool = false
    
    init(
        material: MaterialModel,
        mode: FormMode,
        onSubmit: @escaping (MaterialModel) throws -> Void
    ) {
        self.original = material
        self.draft = material
        self.mode = mode
        self.onSubmit = onSubmit
    }
    
    
    func validateFields() -> Bool {
        nameError = draft.name.isEmpty ? "Required." : nil
        unitCostError = draft.unitCost == 0 ? "Required." : nil
        
        return [
            nameError,
            unitCostError,
        ].allSatisfy { $0 == nil }
    }
    
    func cancelEdits() {
        draft = original
    }
    
    func clearErrors() {
        nameError = nil
        unitCostError = nil
        generalError = nil
    }
    
    @discardableResult
    func trySubmit() -> Bool {
        guard validateFields() else { return false }
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
