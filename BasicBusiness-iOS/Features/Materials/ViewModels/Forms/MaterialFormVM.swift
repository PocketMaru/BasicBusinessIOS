import Foundation
import Observation

@MainActor
@Observable
final class MaterialFormVM {
    
    let mode: FormMode
    
    private(set) var original: MaterialFormState
    var draft: MaterialFormState
    
    private let onSubmit: (MaterialModel) throws -> Void
    
    var name: String {
            get { draft.name }
            set { draft.name = newValue }
        }

    var description: String {
        get { draft.description }
        set { draft.description = newValue }
    }

    var unitType: ProductUnitTypes {
        get { draft.unitType }
        set { draft.unitType = newValue }
    }

    var cost: String {
        get { draft.unitCost }
        set { draft.unitCost = newValue }
    }
    
    var nameError: String? = nil
    var unitCostError: String? = nil
    var generalError: String? = nil
    var showAlert: Bool = false
    init(
        material: MaterialFormState,
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
        let value = Double(draft.unitCost) ?? 0
        unitCostError = value > 0 ? nil : "Must be greater than 0."
        
        return [
            nameError,
            unitCostError,
        ].allSatisfy { $0 == nil }
    }
    
    func liveValidation() -> Bool {
        let validName = name.isEmpty == false
        let validCost = Double(cost) ?? 0 > 0
        let isDirty = self.isDirty()
        return validName && validCost && isDirty
    }
    
    func isDirty() -> Bool {
        draft != original
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
            let newMaterial = try draft.toMaterial()
            try onSubmit(newMaterial)
            return true
        } catch {
            generalError = error.localizedDescription
            showAlert = true
            return false
        }
    }
}
