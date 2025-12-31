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
            Text("Square Footage")
                .foregroundStyle(AppColors.accent)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            Divider()
            
            TextField("",
                value: $method.amount,
                format: .number,
                prompt: Text("Total Sq Ft")
            )
            .focused($focusedField)
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .foregroundStyle(AppColors.secondaryText)
            Divider()
            
            TextField("Price per Sq Ft",
                      value: $method.rate,
                      format: .currency(code: "USD")
            )
            .focused($focusedField)
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .foregroundStyle(AppColors.secondaryText)
        }
        .statBubbleStyle()
        .statButtonBG(emphasis: .subtle)
        .padding(.horizontal, 15)
    }
    
    private var fixedRateFields: some View {
        VStack(alignment: .leading) {
            Text("Fixed Rate")
                .foregroundStyle(AppColors.accent)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            Divider()
            
            TextField("Total",
                      value: $method.amount,
                      format: .currency(code: "USD")
            )
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .foregroundStyle(AppColors.secondaryText)
        }
        .statBubbleStyle()
        .statButtonBG(emphasis: .subtle)
        .padding(.horizontal, 15)
    }
    
    private var liquidSolutionFields: some View {
        VStack(alignment: .leading) {
            Text("Liquid Solution")
                .foregroundStyle(AppColors.accent)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            Divider()
            
            TextField("Liters of Solution",
                      value: $method.amount,
                      format: .number
            )
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .foregroundStyle(AppColors.secondaryText)
            Divider()
            
            TextField("Price per Liter",
                      value: $method.rate,
                      format: .currency(code: "USD")
            )
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .foregroundStyle(AppColors.secondaryText)
        }
        .statBubbleStyle()
        .statButtonBG(emphasis: .subtle)
        .padding(.horizontal, 15)
    }
    
    private var subscriptionFields: some View {
        VStack(alignment: .leading) {
            Text("Subscription Total")
                .foregroundStyle(AppColors.accent)
                .padding(.top, 10)
                .padding(.horizontal, 10)
            Divider()
            
            TextField("Subscription Total",
                      value: $method.amount,
                      format: .currency(code: "USD")
            )
            .keyboardType(.decimalPad)
            .padding(.horizontal, 10)
            .padding(.bottom, 10)
            .foregroundStyle(AppColors.secondaryText)
        }
        .statBubbleStyle()
        .statButtonBG(emphasis: .subtle)
        .padding(.horizontal, 15)
    }
}
