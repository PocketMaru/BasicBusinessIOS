import SwiftUI

struct HVACSectionView: View {
    let form: JobDocumentRouterVM.JobDocumentForm
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            switch form {
            case .quote(let vm):
                PricingMethodsSectionView(form: vm)
            case .invoice(let vm):
                PricingMethodsSectionView(form: vm)
            }
        }
    }
}
