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
            title: userVM.user.businessName,
            primaryIconName: "chart.bar",
            primaryIconTapped: {
            activeSheet = .user
        },
            thirdIconName: "plus.circle",
            thirdIconColor: AppColors.accent,
            thirdIconTapped: {
                
            }
        )
    }
    
}
