import SwiftUI

struct IndustryPricingSection: View {
    let industryType: IndustryType
    let form: JobDocumentRouterFeature.JobDocumentForm
    var body: some View {
        Section {
            industrySpecificFields
            pricingMethodsBlock
        } header: {
            Text("Industry Pricing")
        }
        .statBubbleStyle()
    }
    
    @ViewBuilder
    private var industrySpecificFields: some View {
        switch industryType {
        case .productSales(let priceModel):
            ProductSalesSectionView(form: form, priceModel: priceModel)
        default:
            EmptyView()
        }
    }
    @ViewBuilder
    private var pricingMethodsBlock: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pricing Methods")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(AppColors.accent)

            switch form {
            case .quote(_, let vm):
                PricingMethodsSectionView(pricingMethods: vm.pricingMethodsBinding)
            case .invoice(_, let vm):
                PricingMethodsSectionView(pricingMethods: vm.pricingMethodsBinding)
            }
        }
    }
}
