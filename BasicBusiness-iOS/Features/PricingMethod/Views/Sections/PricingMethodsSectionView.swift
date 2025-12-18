import SwiftUI

struct PricingMethodsSectionView<Form: PricingMethodContaining>: View {
    let form: Form
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(form.pricingMethods) { $method in
                PricingMethodFormView(method: $method)
            }
        }
    }
}
