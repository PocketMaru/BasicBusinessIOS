import SwiftUI

struct IndustryRowView: View {
    var industryType: IndustryType
    var body: some View {
        ForEach(industryType.pricingMethods) { method in
            PricingMethodContent(priceMethod: method)
        }
    }
}
