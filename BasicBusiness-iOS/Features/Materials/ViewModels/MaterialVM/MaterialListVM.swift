import Foundation

@MainActor
@Observable
final class MaterialListVM {
    let materialFeatureVM: MaterialFeatureVM
    
    init(
        materialFeatureVM: MaterialFeatureVM,
    ) {
        self.materialFeatureVM = materialFeatureVM
    }
    
    func addVM() -> MaterialFormVM {
        print("Creating addVM for new material")
        let vm = MaterialFormVM(
            material: MaterialModel(),
            mode: .add,
            onSubmit: { [weak self] draft in
                try self?.addMaterial(from: draft)
            }
        )
        return vm
    }
    
    func editVM(with newMaterial: MaterialModel) -> MaterialFormVM {
        print("Cash MISS -> creating VM for \(newMaterial.id)")
        let vm = MaterialFormVM(
            material: newMaterial,
            mode: .edit,
            onSubmit: { [weak self] draft in
                try self?.updateMaterials(from: draft)
            }
        )
        return vm
    }
    
    func addMaterial(from draft: MaterialModel) throws {
        try materialFeatureVM.addMaterial(from: draft)
    }
    
    func updateMaterials(from draft: MaterialModel) throws {
        try materialFeatureVM.updateMaterials(from: draft)
    }
    
    func deleteMaterial(at index: Int) {
        do {
            try materialFeatureVM.deleteMaterial(at: index)
        } catch {
            print("This will be an alert")
        }
    }
}
