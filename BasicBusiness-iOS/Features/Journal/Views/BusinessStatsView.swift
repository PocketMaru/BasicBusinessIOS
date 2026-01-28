import SwiftUI

enum JournalDestination: Hashable {
    case journal
    case customers
    case materials
}

struct BusinessStatsView: View {
    
    var journalFeature: JournalFeature
    let today: Date = Date()
    @Binding var activeSheet: ActiveUserSheet?
    @State private var journalDestination: [JournalDestination] = []
    
    var body: some View {
        NavigationStack(path: $journalDestination) {
            VStack(alignment: .center, spacing: 25) {
                AppColors.bg.ignoresSafeArea()
                StatDetailComponent(
                    titleOne: "Revenue",
                    valueOne: journalFeature.invoicedRevenue,
                    titleTwo: "Income",
                    valueTwo: journalFeature.totalProfit,
                    titleThree: "Expenses",
                    valueThree: journalFeature.expenseTotal
                )
                .statButtonBG(emphasis: .subtle)
                HStack(spacing: 10) {
                    StatButtonView(label: "Ledger",
                                   tapAction: {
                        journalDestination.append(.customers)
                    })
                    .statButtonBG(emphasis: .raised)
                    
                    StatButtonView(label: "Materials",
                                   tapAction: {
                        journalDestination.append(.materials)
                    })
                    .statButtonBG(emphasis: .raised)
                }
                
                VStack(alignment: .center) {
                    Text(today.formattedMonthDayYear)
                        .fontWeight(.regular)
                        .frame(width: 225)
                }
                .bubbleStyle()
                .statButtonBG(emphasis: .subtle)
                
                CustomMultiForm(
                    titleOne: "Quoted Revenue",
                    valueOne: "\(Int(journalFeature.quotedRevenue))",
                    titleTwo: "Quoted Expenses",
                    valueTwo: "\(Int(journalFeature.forecastedExpense))",
                    titleThree: "Total Open Quotes",
                    valueThree: "\(journalFeature.allQuotes.count)",
                    titleFour: "Total Customers",
                    valueFour: "\(journalFeature.allCustomers.count)",
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
                .statButtonBG(emphasis: .subtle)
                .padding(.horizontal, 15)
                
            }
        }
        .padding(.bottom, 20)
        .background(AppColors.bg)
        .scrollContentBackground(.hidden)
        .navigationDestination(for: JournalDestination.self) {
            route in
            switch route {
            case .journal:
                JournalDetailView(journalFeature: journalFeature)
            case .customers:
                EmptyView()
            case .materials:
                MaterialListView(materialListVM: MaterialListVM(
                    materialFeatureVM: journalFeature.router.materialFeatureVM)
                )
            }
        }
        .ToolBarTitle(
            title: journalFeature.businessName,
            primaryIconName: "chart.bar",
            primaryIconTapped: {
                activeSheet = .user
            },
            thirdIconName: "books.vertical",
            thirdIconColor: AppColors.accent,
            thirdIconTapped: {
                journalDestination.append(.journal)
            }
        )
    }
}
