import SwiftUI

struct PricingMethodFormView: View {
    @Binding var method: PricingMethodModel
    @FocusState private var focusedField: Bool
    
    enum Field {
        case amount
        case rate
    }
    
    var body: some View {
        switch method.type {
        case .squareFootage:
            squareFootageFields
        case .fixedRate:
            fixedRateFields
        case .liquidSolution:
            liquidSolutionFields
        case .subscription:
            subscriptionFields
        case .none:
            EmptyView()
        }
    }
    
    // MARK: - Computed view properties
    
    private var squareFootageFields: some View {
        VStack(alignment: .leading) {
            Section {
                TextField("Square Footage",
                          value: Binding(
                            get: {method.amount ?? 0 },
                            set: {method.amount = $0}
                          ),
                          format: .number)
                .focused($focusedField)
                .keyboardType(.decimalPad)
                Divider()
                TextField("Price per Sq Ft",
                          value: Binding(
                            get: { method.rate ?? 0 },
                            set: { method.rate = $0 }
                          ),
                          format: .currency(code: "USD"))
                .focused($focusedField)
                .keyboardType(.decimalPad)
            } header: {
                Text("Pricing Methods")
            }
        }
    }
    
    private var fixedRateFields: some View {
        TextField("Fixed Rate",
                  value: Binding(
                    get: { method.amount ?? 0 },
                    set: { method.amount = $0}
                  ),
                  format: .currency(code: "USD")
        )
        .keyboardType(.decimalPad)
    }
    
    private var liquidSolutionFields: some View {
        VStack(alignment: .leading) {
            TextField("Liters of Solution",
                      value: Binding(
                        get: { method.amount ?? 0 },
                        set: { method.amount = $0 }
                      ),
                      format: .number
            )
            .keyboardType(.decimalPad)
            Divider()
            TextField("Price per Liter",
                      value: Binding(
                        get: { method.rate ?? 0 },
                        set: { method.rate = $0}
                      ),
                      format: .currency(code: "USD")
            )
            .keyboardType(.decimalPad)
        }
    }
    
    private var subscriptionFields: some View {
        TextField("Subscription Amount",
                  value: Binding(
                    get: { method.amount ?? 0 },
                    set: { method.amount = $0}
                  ),
                  format: .currency(code: "USD")
        )
        .keyboardType(.decimalPad)
    }
}
