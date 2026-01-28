import SwiftUI

struct MaterialListView: View {
    @Bindable var materialListVM: MaterialListVM
    @State private var addViewIsPresented: Bool = false
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            List {
                ForEach(materialListVM.materialFeatureVM.allMaterials, id: \.id) { material in
                    NavigationLink(
                        destination: MaterialDetailView(
                            material: materialListVM.editVM(with: material)
                        )
                    ) {
                        HStack {
                            Image(systemName: "book.and.wrench")
                                .foregroundColor(AppColors.accent)
                                .frame(width: 32, height: 32)
                                .padding(.leading, 8)
                            Text(material.name)
                                .foregroundStyle(AppColors.text)
                        }
                    }
                    .listRowBackground(AppColors.bg)
                }
                .onDelete { indexSet in
                    for index in indexSet{
                        materialListVM.deleteMaterial(at: index)
                    }
                }
            }
            .padding(.top, 30)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $addViewIsPresented) {
                NavigationStack {
                    AddMaterialView(
                        materialListVM: materialListVM,
                        newMaterial: materialListVM.addVM()
                    )
                }
            }
        }
        .ToolBarTitle(
            title: "Materials",
            primaryIconName: nil,
            thirdIconName: "plus.circle",
            thirdIconColor: AppColors.accent,
            thirdIconTapped: {
                addViewIsPresented = true
            }
        )
    }
}
