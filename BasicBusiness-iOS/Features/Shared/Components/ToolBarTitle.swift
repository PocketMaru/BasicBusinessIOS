import SwiftUI
// My version of liquid glass for titles, light and dark mode variants.
extension View {
    func ToolBarTitle(
        title: String = "Basic Business",
        iconName: String? = "chart.bar",
        mainIconTapped: (() -> Void)? = nil,
        
        editIconName: String? = "person.circle.fill",
        editMode: Binding<Bool>? = nil,
        editButtonColor: Color? = nil,
        editIconTapped: (() -> Void)? = nil,
        
        secondaryIconName: String? = "book.fill",
        secondaryMode: Binding<Bool>? = nil,
        secondaryColor: Color? = nil,
        secondaryIconTapped: (() -> Void)? = nil,
        
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .bubbleStyle(textColor: AppColors.accent)
                        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
                }
                if let icon = iconName, !icon.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        if let action = mainIconTapped {
                            Button(action: action) {
                                Image(systemName: icon)
                                    .font(.title3.bold())
                                    .foregroundStyle(AppColors.accent)
                            }
                        }
                        else {
                            Image(systemName: icon)
                                .font(.title3.bold())
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
                if let action = secondaryIconTapped, let secondaryIconName, let secondaryColor {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(systemName: secondaryIconName)
                                .font(.title3.bold())
                                .foregroundStyle(secondaryColor)
                        }
                    }
                }
                if let action = editIconTapped, let editIconName = editIconName, let editButtonColor {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(systemName: editIconName)
                                .font(.title3.bold())
                                .foregroundStyle(editButtonColor)
                        }
                    }
                }
            }
    }
}

// MARK: - Future implementation of a more scalable toolbar

//struct ToolbarButton: Identifiable {
//    let id = UUID()
//    let systemName: String
//    let color: Color
//    let action: () -> Void
//}
//
//extension View {
//    func ToolBarTitle(
//        title: String = "Basic Business",
//        leadingButtons: [ToolbarButton] = [],
//        trailingButtons: [ToolbarButton] = []
//    ) -> some View {
//        self
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                // Center title
//                ToolbarItem(placement: .principal) {
//                    Text(title)
//                        .bubbleStyle(textColor: AppColors.accent)
//                        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
//                }
//
//                // Leading group
//                if !leadingButtons.isEmpty {
//                    ToolbarItemGroup(placement: .topBarLeading) {
//                        ForEach(leadingButtons) { btn in
//                            Button(action: btn.action) {
//                                Image(systemName: btn.systemName)
//                                    .font(.title3.bold())
//                                    .foregroundStyle(btn.color)
//                            }
//                        }
//                    }
//                }
//
//                // Trailing group
//                if !trailingButtons.isEmpty {
//                    ToolbarItemGroup(placement: .topBarTrailing) {
//                        ForEach(trailingButtons) { btn in
//                            Button(action: btn.action) {
//                                Image(systemName: btn.systemName)
//                                    .font(.title3.bold())
//                                    .foregroundStyle(btn.color)
//                            }
//                        }
//                    }
//                }
//            }
//    }
//}


// this is a representation of implementation of the new toolbar when refactor occurs

//    .ToolBarTitle(
//        title: "Documents",
//        leadingButtons: [
//            .init(systemName: "chart.bar", color: AppColors.accent) { ... }
//        ],
//        trailingButtons: [
//            .init(systemName: "book.fill", color: AppColors.accent) { ... },
//            .init(systemName: "plus.circle.fill", color: AppColors.success) { ... }
//        ]
//    )
