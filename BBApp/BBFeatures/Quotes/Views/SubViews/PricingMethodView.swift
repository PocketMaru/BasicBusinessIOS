//
//  QuoteSummaryView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct PricingMethodView: View {
    @Binding var method: PricingMethod
    @State private var amountText: Double = 0
    @State private var rateText: Double = 0
    @FocusState private var isFocused: Bool
    var body: some View {
        switch method {
        case .squareFootage(let amount, let rate):
            VStack(alignment: .leading) {
                CustomFormView(header: "Square Footage") {
                    VStack(spacing: 8) {
                        TextField("Square Footage",
                                  value: $amountText,
                                  format: .number)
                        .focused($isFocused)
                        .hideKeyboardOnTap()
                        .keyboardType(.decimalPad)
                        
                        TextField("Price per Sq Ft",
                                  value: $rateText,
                                  format: .currency(code: "USD"))
                        .focused($isFocused)
                        .hideKeyboardOnTap()
                        .keyboardType(.decimalPad)
                    }
                    
                }
            }
            .onAppear {
                // initialize once so you don't type into a zeroed field
                amountText = amount
                rateText = rate
            }
            .onChange(of: isFocused) { isFocused, _ in
                if !isFocused {
                    let amount = amountText
                    let rate = rateText
                    commitSqrftChanges(amount: amount, rate: rate)
                }
            }
        case .fixedRate(let value):
            CustomFormView(header: "Fixed Rate") {
                TextField("Fixed Rate",
                          value: Binding(
                            get: { value },
                            set: { newValue in
                                method = .fixedRate(newValue)
                            }
                          ),
                          format: .currency(code: "USD")
                )
                .keyboardType(.decimalPad)
            }
        case .liquidSolution(let amount, let rate):
            VStack(alignment: .leading) {
                CustomFormView(header: "Liter Total") {
                    TextField("Liters of Solution",
                              value: Binding(
                                get: { amount },
                                set: { newAmount in
                                    method = .liquidSolution(amount: newAmount, rate: rate)
                                }
                              ),
                              format: .number
                    )
                    .keyboardType(.decimalPad)
                }
                CustomFormView(header: "Pricer Per Liter") {
                    TextField("Price per Liter",
                              value: Binding(
                                get: { rate },
                                set: { newRate in
                                    method = .liquidSolution(amount: amount, rate: newRate)
                                }
                              ),
                              format: .currency(code: "USD")
                    )
                    .keyboardType(.decimalPad)
                }
            }
        case .subscription(let value):
            CustomFormView(header: "Industry Fields") {
                TextField("Subscription Amount",
                          value: Binding(
                            get: { value },
                            set: { newValue in
                                method = .subscription(newValue)
                            }
                          ),
                          format: .currency(code: "USD")
                )
                .keyboardType(.decimalPad)
            }
        case .none:
            EmptyView()
        }
    }
    private func commitSqrftChanges(amount: Double, rate: Double) {
        method = .squareFootage(amount: amount, rate: rate)
    }
}
