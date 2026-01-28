import SwiftUI

struct AddMaterialView: View {
    @Bindable var materialListVM: MaterialListVM
    @Bindable var newMaterial: MaterialFormVM
    @State private var isEditing: Bool = true
    @State private var attemptedSave: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            VStack {
                MultiForm(fields: [
                    .init(
                        title: "Name",
                        value: newMaterial.name,
                        edit: EditControl.textField($newMaterial.name),
                        errorMessage: newMaterial.nameError
                    ),
                    .init(
                        title: "Type",
                        value: newMaterial.unitType.displayName,
                        edit: EditControl.materialTypePicker($newMaterial.unitType),
                          errorMessage: nil
                    ),
                    .init(
                        title: "Description",
                        value: newMaterial.description,
                        edit: EditControl.textField($newMaterial.description),
                        errorMessage: nil
                    ),
                    .init(
                        title: "Cost Per \(newMaterial.unitType.displayName)",
                        value: newMaterial.cost,
                        edit: EditControl.textField($newMaterial.cost),
                        errorMessage: newMaterial.unitCostError
                    )
                ], isEditing: isEditing, attemptedSave: attemptedSave)
                Spacer()
            }
            .padding(.horizontal, 15)
            .ToolBarTitle(
                title: "New Material",
                primaryIconName: "x.circle",
                primaryIconTapped: {
                    dismiss()
                },
                thirdIconName: "checkmark.circle.fill",
                thirdIconColor: newMaterial.validateFields() ? AppColors.success : AppColors.accent,
                thirdIconTapped: {
                    attemptedSave = true
                    let success = newMaterial.trySubmit()
                    if success {
                        dismiss()
                    }
                }
            )
        }
    }
}
