import Foundation

@MainActor
@Observable
final class DocumentMaterialListVM {
    let documentMaterialFeature: DocumentMaterialFeature
    let materialFeature: MaterialFeature
    let invoiceFeature: InvoiceFeatureVM
    let quoteFeature: QuoteFeatureVM
    
    init(
        documentMaterialFeature: DocumentMaterialFeature,
        materialFeature: MaterialFeature,
        invoiceFeature: InvoiceFeatureVM,
        quoteFeature: QuoteFeatureVM
    ) {
        self.documentMaterialFeature = documentMaterialFeature
        self.materialFeature = materialFeature
        self.invoiceFeature = invoiceFeature
        self.quoteFeature = quoteFeature
    }
    
    func addVM(
        from material: MaterialModel,
        document: DocumentRef
    ) -> DocumentMaterialFormVM {
        print("Creating addVM for new document material")
        let documentMaterialModel = DocumentMaterialModel(
            materialID: material.id,
            document: document,
            isExpense: false,
            quantity: 1
        )
        let vm = DocumentMaterialFormVM(
            material: documentMaterialModel,
            mode: .add,
            onSubmit: { [weak self] draft in
                try self?.addDocumentMaterial(from: draft)
            }
        )
        return vm
    }
    
    func editVM(
        with newDocumentMaterial: DocumentMaterialModel
    ) -> DocumentMaterialFormVM {
        print("Cash MISS -> creating VM for \(newDocumentMaterial.id)")
        let vm = DocumentMaterialFormVM(
            material: newDocumentMaterial,
            mode: .edit,
            onSubmit: { [weak self] draft in
                try self?.updateDocumentMaterials(from: draft)
            }
        )
        return vm
    }
    
    func addDocumentMaterial(from draft: DocumentMaterialModel) throws {
        try documentMaterialFeature.addDocumentMaterial(draft, availableMaterials: materialFeature.allMaterials)
    }
    
    func updateDocumentMaterials(from draft: DocumentMaterialModel) throws {
        try documentMaterialFeature.updateDocumentMaterials(draft, availableMaterials: materialFeature.allMaterials)
    }
    
    func deleteDocumentMaterial(at index: Int) {
        do {
            try documentMaterialFeature.deleteDocumentMaterial(at: index)
        } catch {
            print("This will be an alert")
        }
    }
}
