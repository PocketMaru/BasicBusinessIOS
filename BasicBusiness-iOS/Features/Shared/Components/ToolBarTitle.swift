import SwiftUI
// My version of liquid glass for titles, light and dark mode variants.
extension View {
    func ToolBarTitle(
        title: String = "Basic Business",
        
        primaryIconName: String? = "",
        primaryIconTapped: (() -> Void)? = nil,
        primaryIconColor: Color? = nil,
        
        editIconName: String? = "",
        toggleEditIconState: Binding<Bool>? = nil,
        editIconTapped: (() -> Void)? = nil,
        editIconColor: Color? = nil,
        
        calendarAction: ((DocumentDateFilter) -> Void)? = nil,
        
        onCreateQuote: (() -> Void)? = nil,
        onCreateInvoice: (() -> Void)? = nil,
        
        thirdIconName: String? = "",
        thirdIconColor: Color? = nil,
        toggleThirdIconState: Binding<Bool>? = nil,
        thirdIconTapped: (() -> Void)? = nil,
        
    ) -> some View {
        self
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
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
                if let editIconTapped = editIconTapped, let editIconColor = editIconColor, let editIconName = editIconName {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            toggleEditIconState?.wrappedValue.toggle()
                            editIconTapped()
                        } label: {
                            Image(systemName: editIconName )
                                .font(.title3.bold())
                                .foregroundStyle(editIconColor)
                        }
                    }
                    
                }
                if let calendarAction = calendarAction {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button {
                                calendarAction(.today)
                            } label: {
                                Label("Today", systemImage: "calendar.circle.fill")
                                    
                            }
                            Button {
                                calendarAction(.thisWeek)
                            } label: {
                                Label("This Week", systemImage: "calendar.badge.clock")
                                    
                            }
                            Button {
                                calendarAction(.thisMonth)
                            } label: {
                                Label("This Month", systemImage: "calendar")
                                    
                            }
                        } label: {
                            Image(systemName: "calendar")
                                .font(.title3.bold())
                        }
                    }
                }
                if let onCreateQuote = onCreateQuote, let onCreateInvoice {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button {
                                onCreateQuote()
                            }
                            label: {
                                Label("Create Quote", systemImage: "plus.circle")
                            }
                            
                            Button {
                                onCreateInvoice()
                            }
                            label: {
                                Label("Create Invoice", systemImage: "plus.circle.fill")
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.title3.bold())
                        }
                    }
                }
                if let action = thirdIconTapped, let thirdIconName = thirdIconName, let thirdIconColor = thirdIconColor {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: action) {
                            Image(systemName: thirdIconName)
                                .font(.title3.bold())
                                .foregroundStyle(thirdIconColor)
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
