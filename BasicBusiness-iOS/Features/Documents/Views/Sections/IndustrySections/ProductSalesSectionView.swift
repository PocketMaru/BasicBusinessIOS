import SwiftUI

struct ProductSalesSectionView: View {
    let form: JobDocumentRouterFeature.JobDocumentForm
    let priceModel: ProductSalesQM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            CustomFormView(header: "Item") {
                TextField("Item", text: .constant(priceModel.item ?? ""))
            }
            CustomFormView(header: "Quantity") {
                TextField("Amount", text: .constant("\(priceModel.quantity ?? 0)"))
            }
        }
    }
}
