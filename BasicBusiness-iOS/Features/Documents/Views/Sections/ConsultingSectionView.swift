import SwiftUI

struct ConsultingSectionView: View {
    @Bindable var quoteFormVM: QuoteFormVM
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach($quoteFormVM.draft.pricingMethods) { $method in
                PricingMethodFormView(method: $method)
            }
        }
    }
}
