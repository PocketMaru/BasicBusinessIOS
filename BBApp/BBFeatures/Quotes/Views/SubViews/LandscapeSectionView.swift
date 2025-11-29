import SwiftUI

struct LandscapeSectionView: View {
    @Bindable var quoteFormVM: QuoteFormVM
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach($quoteFormVM.draft.pricingMethods, id: \.self) { $method in
                PricingMethodView(method: $method)
            }
        }
    }
}

