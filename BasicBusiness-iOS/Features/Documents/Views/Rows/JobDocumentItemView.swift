import SwiftUI

struct JobDocumentItemView: View {
    var document: JobDocumentRowData
    
    var body: some View {
        CustomSectionView(
            headerTitle: document.customerName
        ) {
            VStack {
                Text(String(document.totalCost))
                Divider()
                Text("\(document.date.formattedMonthDayYear)")
                Divider()
                Text("\(document.documentType.rawValue)")
                Spacer()
            }
        }
        .statBubbleStyle()
        .statButtonBG()
        .padding(.horizontal, 40)
    }
}
