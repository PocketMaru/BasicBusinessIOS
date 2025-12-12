import Foundation

@MainActor
@Observable
final class ExpenseListVM {
    private(set) var allExpenses: [ExpenseModel] = []
    
    init() {
        
    }
    
    func addExpense(_ expense: ExpenseModel) {
        allExpenses.append(expense)
    }
    
    func removeExpense(at index: Int){
        guard index >= 0 && index < allExpenses.count else { return }
        allExpenses.remove(at: index)
    }
}
