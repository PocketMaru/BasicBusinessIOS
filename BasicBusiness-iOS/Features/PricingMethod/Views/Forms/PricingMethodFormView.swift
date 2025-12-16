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
            CustomFormView(header: "Square Footage") {
                TextField("Square Footage",
                          value: Binding(
                            get: {method.amount ?? 0 },
                            set: {method.amount = $0}
                          ),
                          format: .number)
                .focused($focusedField)
                .keyboardType(.decimalPad)
            }
            
            CustomFormView(header:"Price Per Sq Ft") {
                TextField("Price per Sq Ft",
                          value: Binding(
                            get: { method.rate ?? 0 },
                            set: { method.rate = $0 }
                          ),
                          format: .currency(code: "USD"))
                .focused($focusedField)
                .keyboardType(.decimalPad)
            }
        }
    }
    
    private var fixedRateFields: some View {
        CustomFormView(header: "Fixed Rate") {
            TextField("Fixed Rate",
                      value: Binding(
                        get: { method.amount ?? 0 },
                        set: { method.amount = $0}
                      ),
                      format: .currency(code: "USD")
            )
            .keyboardType(.decimalPad)
        }
    }
    
    private var liquidSolutionFields: some View {
        VStack(alignment: .leading) {
            CustomFormView(header: "Liter Total") {
                TextField("Liters of Solution",
                          value: Binding(
                            get: { method.amount ?? 0 },
                            set: { method.amount = $0 }
                          ),
                          format: .number
                )
                .keyboardType(.decimalPad)
            }
            
            CustomFormView(header: "Pricer Per Liter") {
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
    }
    
    private var subscriptionFields: some View {
        CustomFormView(header: "Industry Fields") {
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
}
