//
//  StatBubbleView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/13/25.
//

import SwiftUI

struct StatButtonView: View {
    let label: String
    let value: Double?
    let tapAction: () -> Void
    
    var body: some View {
        Button(action: tapAction) {
            VStack(spacing: 10) {
                Text(label)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppColors.accent)
                if let value = value {
                    Text(value.formatted(.number.precision(.fractionLength(0))))
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(AppColors.secondaryText)
                }
                
            }
            .frame(width: 180, height: 120)
            .statBubbleStyle()
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
            HStack(spacing: 20) {
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
                            .font(.system(size: 33, weight: .bold))
                            .foregroundStyle(AppColors.secondaryText)
                        Text(titleTwo)
                            .font(.system(size: 23, weight: .medium))
                            .foregroundStyle(AppColors.accent)
                    }
                }
                Divider()
                if let valueThree = valueThree, let titleThree = titleThree {
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
            HStack(spacing: 20) {
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

