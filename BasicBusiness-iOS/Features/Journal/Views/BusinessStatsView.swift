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
            VStack(alignment: .center, spacing: 15) {
                AppColors.bg.ignoresSafeArea()
                StatDetailComponent(
                    titleOne: "Revenue",
                    valueOne: journalFeature.invoicedRevenue,
                    titleTwo: "Income",
                    valueTwo: journalFeature.totalProfit,
                    titleThree: "Expenses",
                    valueThree: journalFeature.expenseTotal
                )
                .statButtonBG(emphasis: .raised)
                HStack(spacing: 15) {
                    StatButtonView(label: "Status",
                                   value: Double(journalFeature.customerFeature.allCustomers.count),
                                   tapAction: {
                        journalDestination.append(.customers)
                    })
                    .statButtonBG(emphasis: .raised)
                    
                    StatButtonView(label: "Materials",
                                   value: Double(journalFeature.allMaterials.count),
                                   tapAction: {
                        journalDestination.append(.materials)
                    })
                    .statButtonBG(emphasis: .raised)
                }
                
                VStack(alignment: .center) {
                    Text("Journal")
                        .fontWeight(.semibold)
                    Divider()
                        .padding(.horizontal, 24)
                        .frame(width: 300)
                    Text(today.formattedMonthDayYear)
                        .fontWeight(.regular)
                }
                .bubbleStyle()
                .statButtonBG(emphasis: .raised)
                .padding(.top, 10)
                
                Button {
                    journalDestination.append(.journal)
                } label: {
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
                }
            }
        }
        .padding([.bottom,.horizontal])
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
                EmptyView()
            }
        }
        .ToolBarTitle(
            businessName: journalFeature.businessName,
            primaryIconTapped: {
                activeSheet = .user
            })
    }
}
