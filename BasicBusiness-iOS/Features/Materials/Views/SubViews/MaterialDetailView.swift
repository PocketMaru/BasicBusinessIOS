import SwiftUI

struct MaterialDetailView: View {
    @Bindable var material: MaterialFormVM
    @State private var isEditing: Bool = false
    @State private var attemptedSave: Bool = false
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            VStack {
                MultiForm(fields: [
                    .init(
                        title: "Name",
                        value: material.draft.name,
                        edit: EditControl.textField($material.draft.name), errorMessage: material.nameError),
                    .init(
                        title: "Type",
                        value: material.draft.unitType.displayName,
                        edit: EditControl.materialTypePicker($material.draft.unitType),
                        errorMessage: nil),
                    .init(
                        title: "Description",
                        value: material.draft.description,
                        edit: EditControl.textField($material.draft.description),
                        errorMessage: nil),
                    .init(
                        title: "Cost",
                        value: "\(material.draft.unitCost) Per \(material.unitType.displayName)",
                        edit: EditControl.textField($material.draft.unitCost, placeholder: "Per \(material.unitType.displayName)"),
                        errorMessage: nil)
                ], isEditing: isEditing, attemptedSave: attemptedSave)
            }
            .padding(.bottom, 450)
            .padding(.horizontal, 15)
            .ToolBarTitle(
                title: material.name,
                primaryIconName: nil,
                editIconName: isEditing ? "checkmark.circle.fill" : "pencil.circle.fill",
                editIconTapped: {
                    if !isEditing {
                            attemptedSave = false
                            isEditing = true
                            return
                        }
                    
                        attemptedSave = true

                        let success = material.trySubmit()
                        if success {
                            isEditing = false
                        }
                },
                editIconColor: (!isEditing || material.liveValidation())
                ? AppColors.accent
                : AppColors.accent.opacity(0.3)
            )
        }
    }
}
