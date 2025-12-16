import SwiftUI

struct ExpenseView: View {
    @Bindable var userVM: UserVM
    @Binding var activeSheet: ActiveUserSheet?
    var body: some View {
        ZStack {
            AppColors.bg.ignoresSafeArea()
            ScrollView {
                VStack {
                    Text("Expense View")
                        .padding()
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .ToolBarTitle(
            businessName: userVM.user.businessName,
            primaryIconTapped: {
            activeSheet = .user
        })
    }
    
}
