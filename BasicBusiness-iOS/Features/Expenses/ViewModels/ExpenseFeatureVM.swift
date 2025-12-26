import Foundation

@MainActor
@Observable
final class ExpenseFeatureVM {
    var allExpenses: [ExpenseModel] = []
}
