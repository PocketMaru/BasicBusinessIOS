//
//  QuoteSummaryView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct PricingMethodView: View {
    @Binding var method: PricingMethod

    var body: some View {
        switch method {
        case .squareFootage(let amount, let rate):
            VStack(alignment: .leading) {
                CustomFormView(header: "Square Footage") {
                    TextField("Square Footage",
                              value: Binding(
                                get: { amount },
                                set: { newAmount in
                                    method = .squareFootage(amount: newAmount, rate: rate)
                                }
                              ),
                              format: .number
                    )
                    .keyboardType(.decimalPad)
                }
                CustomFormView(header: "Price Per Square Foot") {
                    TextField("Price per Sq Ft",
                              value: Binding(
                                get: { rate },
                                set: { newRate in
                                    method = .squareFootage(amount: amount, rate: newRate)
                                }
                              ),
                              format: .currency(code: "USD")
                    )
                    .keyboardType(.decimalPad)
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
}
