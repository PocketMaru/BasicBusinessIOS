import SwiftUI

struct JournalDetailView: View {
    var journalFeature: JournalFeature
    var body: some View {
        VStack(alignment: .center, spacing: 25) {
            AppColors.bg.ignoresSafeArea()
            CustomMultiForm(
                titleOne: "Revenue",
                valueOne: "\(journalFeature.invoicedRevenue)",
                titleTwo: "Expenses",
                valueTwo: "\(journalFeature.expenseTotal)",
                titleThree: "Forecasted Revenue",
                valueThree: "\(journalFeature.forecastedProfit)",
                titleFour: "Forecasted Expenses",
                valueFour: "\(journalFeature.forecastedExpenseTotal)",
                titleFive: nil,
                valueFive: nil,
                titleSix: nil,
                valueSix: nil,
                titleSeven: nil,
                valueSeven: nil,
                titleEight: nil,
                valueEight: nil,
                titleNine: nil,
                valueNine: nil,
                titleTen: nil,
                valueTen: nil,
                titleEleven: nil,
                valueEleven: nil
            )
            .statButtonBG(emphasis: .raised)
            .padding(.horizontal, 15)
            
            List {
                
            }
        }
        .padding(.bottom, 10)
        .background(AppColors.bg)
        .scrollContentBackground(.hidden)
    }
}
