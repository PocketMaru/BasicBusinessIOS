import SwiftUI

struct StatButtonView: View {
    let label: String
    let labelTwo:String?
    let labelThree:String?
    let value: Double?
    let valueTwo: Double?
    let tapAction: () -> Void
    let isSelected: Bool
    
    init(
        label: String,
        labelTwo:String? = nil,
        labelThree:String? = nil,
        value: Double? = nil,
        valueTwo: Double? = nil,
        tapAction: @escaping () -> Void,
        isSelected: Bool = false
    ) {
        self.label = label
        self.labelTwo = labelTwo
        self.labelThree = labelThree
        self.value = value
        self.valueTwo = valueTwo
        self.tapAction = tapAction
        self.isSelected = isSelected
    }
    var body: some View {
        Button(action: tapAction) {
            VStack(spacing: 10) {
                if let labelTwo, !labelTwo.isEmpty {
                    VStack(alignment: .center, spacing: 5) {
                        Text(label)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                        HStack {
                            Spacer()
                            VStack {
                                
                                Text(labelTwo)
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(AppColors.accent)
                                
                                if let value = value {
                                    Text(value.formatted(.number.precision(.fractionLength(0))))
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundStyle(AppColors.secondaryText)
                                }
                            }
                            Spacer()
                            VStack {
                                if let labelThree = labelThree {
                                    Text(labelThree)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(AppColors.accent)
                                }
                                if let valueTwo = valueTwo {
                                    Text(valueTwo.formatted(.number.precision(.fractionLength(0))))
                                        .font(.system(size: 28, weight: .bold))
                                        .foregroundStyle(AppColors.secondaryText)
                                }
                            }
                        }
                    }
                } else {
                    Text(label)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(AppColors.accent)
                    if let value = value {
                        Text(value.formatted(.number.precision(.fractionLength(0))))
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    
                }
            }
            .frame(width: 180, height: 120)
            .statBubbleStyle()
            .statButtonBG(isVisible: isSelected)
            .frame(width: 180, height: 120)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
    }
}

struct LargeStatButtonView: View {
    let titleOne: String
    let valueOne: Double
    
    let titleTwo: String
    let valueTwo: Double
    
    let titleThree: String?
    let valueThree: Double?
    
    let tapActionOne: () -> Void
    let tapActionTwo: (() -> Void)?
    let tapActionThree: (() -> Void)?
    
    init(
        titleOne: String,
        valueOne: Double,
        titleTwo: String,
        valueTwo: Double,
        titleThree: String? = nil,
        valueThree: Double? = nil,
        tapActionOne: @escaping () -> Void,
        tapActionTwo: (() -> Void)? = nil,
        tapActionThree: (() -> Void)? = nil
    ) {
        self.titleOne = titleOne
        self.valueOne = valueOne
        self.titleTwo = titleTwo
        self.valueTwo = valueTwo
        self.titleThree = titleThree
        self.valueThree = valueThree
        self.tapActionOne = tapActionOne
        self.tapActionTwo = tapActionTwo
        self.tapActionThree = tapActionThree
    }
    var body: some View {
        if titleThree != nil {
            HStack(alignment: .center, spacing: 27) {
                Button(action: tapActionOne) {
                    VStack(spacing: 4) {
                        Text(valueOne.formatted(.number.precision(.fractionLength(0))))
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                        Text(titleOne)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                    }
                }
                
                Divider()
                
                Button(action: tapActionTwo ?? { }) {
                    VStack(spacing: 4) {
                        Text(valueTwo.formatted(.number.precision(.fractionLength(0))))
                            .font(.system(size: 31, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                        Text(titleTwo)
                            .font(.system(size: 21, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                    }
                    .offset( y: -2)
                }
                
                if let valueThree = valueThree, let titleThree = titleThree {
                    Divider()
                    
                    Button(action: tapActionThree ?? { }) {
                        VStack(spacing: 4) {
                            Text(valueThree.formatted(.number.precision(.fractionLength(0))))
                                .font(.system(size: 28, weight: .bold))
                                .foregroundStyle(AppColors.secondaryText)
                            Text(titleThree)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(AppColors.accent)
                        }
                    }
                }
            }
            .frame(width: 400, height: 120)
            .statBubbleStyle()
        } else {
            HStack(alignment: .center, spacing: 20) {
                Button(action: tapActionOne) {
                    VStack(spacing: 4) {
                        Text(valueOne.formatted(.number.precision(.fractionLength(0))))
                            .font(.system(size: 35, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                        Text(titleOne)
                            .font(.system(size: 25, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                    }
                    .frame(maxWidth: .infinity)
                }
                Divider()
                Button(action: tapActionTwo ?? { }) {
                    VStack(spacing: 4) {
                        Text(valueTwo.formatted(.number.precision(.fractionLength(0))))
                            .font(.system(size: 35, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                        Text(titleTwo)
                            .font(.system(size: 25, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .frame(width: 360, height: 120)
            .statBubbleStyle()
        }
    }
}

