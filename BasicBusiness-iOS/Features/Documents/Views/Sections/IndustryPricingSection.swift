import SwiftUI

#warning("UI needs to be modified to a list")
struct IndustryPricingSection: View {
    let industryType: IndustryType
    @Binding var pricingMethods: [PricingMethodModel]
    let isVisible: Bool
    var body: some View {
        if isVisible {
            Section {
                Divider()
                industrySpecificFields
                pricingMethodsBlock
            }
        }
    }
    
    @ViewBuilder
    private var industrySpecificFields: some View {
        switch industryType {
        case .productSales(let priceModel):
            ProductSalesSectionView(priceModel: priceModel)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var pricingMethodsBlock: some View {
        VStack(alignment: .leading, spacing: 5) {
            PricingMethodsSectionView(pricingMethods: $pricingMethods)
        }
    }
}
