import SwiftUI
// My version of liquid glass for titles, light and dark mode variants.
extension View {
    func ToolBarTitle(
        businessName: String = "Basic Business",
        
        primaryIconName: String? = "chart.bar",
        primaryIconTapped: (() -> Void)? = nil,
        primaryIconColor: Color? = nil,
        
        secondIconName: String? = "person.circle.fill",
        toggleSecondIconState: Binding<Bool>? = nil,
        secondButtonColor: Color? = nil,
        secondIconTapped: (() -> Void)? = nil,
        
        thirdIconName: String? = "book.fill",
        toggleThirdIconState: Binding<Bool>? = nil,
        thirdButtonColor: Color? = nil,
        thirdIconTapped: (() -> Void)? = nil,
        
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(businessName)
                        .bubbleStyle(textColor: AppColors.accent)
                        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
                }
                if let icon = primaryIconName, !icon.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        if let action = primaryIconTapped {
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
                if let action = secondIconTapped, let secondIconName, let secondButtonColor, let toggleSecondIconState {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            toggleSecondIconState.wrappedValue.toggle()
                            action()
                        } label: {
                            Image(systemName: secondIconName)
                                .font(.title3.bold())
                                .foregroundStyle(secondButtonColor)
                        }
                        .buttonStyle(.plain)
                        .popover(
                                    isPresented: toggleSecondIconState,
                                    attachmentAnchor: .rect(.bounds),
                                    arrowEdge: .top,
                                ) {
                                    CalendarQuickActions(
                                        dismiss: {
                                                    toggleSecondIconState.wrappedValue = false
                                                }
                                    )
                                    
                                        .presentationCompactAdaptation(.popover)
                                        .presentationBackground(AppColors.bg)
                                        .presentationCornerRadius(22)
                                }
                    }
                }
                if let action = thirdIconTapped, let thirdIconName = thirdIconName, let thirdButtonColor {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(systemName: thirdIconName)
                                .font(.title3.bold())
                                .foregroundStyle(thirdButtonColor)
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
