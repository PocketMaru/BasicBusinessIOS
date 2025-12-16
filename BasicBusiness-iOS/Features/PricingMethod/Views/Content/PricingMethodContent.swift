import SwiftUI

struct PricingMethodContent: View {
    var priceMethod: PricingMethodModel
    var body: some View {
        HStack {
            Text("\(priceMethod.type.rawValue.capitalized)")
                .font(.headline)
            Spacer()
            if let rate = priceMethod.rate {
                Text("\(rate)")
            }
            
            if let amount = priceMethod.amount {
                Text("\(amount)")
            }
        }
    }
}
