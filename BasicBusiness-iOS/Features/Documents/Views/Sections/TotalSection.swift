import SwiftUI

struct TotalSection: View {
    let total: Double
    let isVisible: Bool
    var body: some View {
        VStack(alignment: .center) {
            if isVisible {
                Divider()
                Text("Total")
                    .foregroundStyle(AppColors.accent)
                    .padding(.horizontal, 15)
                Text(total, format: .currency(code: "USD"))
                    .bubbleStyle()
                    .statButtonBG(emphasis:.raised)
            }
        }
        .padding(.bottom, 10)
    }
}
