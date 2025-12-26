import Foundation
import SwiftUI

struct StatDetailComponent: View {
    let titleOne: String
    let valueOne: Double
    let titleTwo: String
    let valueTwo: Double
    let titleThree: String
    let valueThree: Double
    
    var body: some View {
        HStack(alignment: .center, spacing: 27) {
            VStack(spacing: 4) {
                Text(valueOne.formatted(.number.precision(.fractionLength(0))))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(AppColors.secondaryText)
                Text(titleOne)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            
            Divider()
            VStack(spacing: 4) {
                Text(valueTwo.formatted(.number.precision(.fractionLength(0))))
                    .font(.system(size: 31, weight: .bold))
                    .foregroundStyle(AppColors.secondaryText)
                Text(titleTwo)
                    .font(.system(size: 21, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            .offset( y: -2)
            
            Divider()
            VStack(spacing: 4) {
                Text(valueThree.formatted(.number.precision(.fractionLength(0))))
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(AppColors.secondaryText)
                Text(titleThree)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
        }
        .frame(width: 400, height: 120)
        .statBubbleStyle()
    }
}
