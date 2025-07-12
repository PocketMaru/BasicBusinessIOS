//
//  CustomMultiForm.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 7/4/25.
//

import SwiftUI

struct CustomMultiForm: View {
    let titleOne: String
    let valueOne: String
    let titleTwo: String?
    let valueTwo: String?
    let titleThree: String?
    let valueThree: String?
    let titleFour: String?
    let valueFour: String?
    let titleFive: String?
    let valueFive: String?
    let titleSix: String?
    let valueSix: String?
    let titleSeven: String?
    let valueSeven: String?
    
    init(
        titleOne: String,
        valueOne: String,
        titleTwo: String?,
        valueTwo: String?,
        titleThree: String?,
        valueThree: String?,
        titleFour: String?,
        valueFour: String?,
        titleFive: String?,
        valueFive: String?,
        titleSix: String?,
        valueSix: String?,
        titleSeven: String?,
        valueSeven: String?
    ) {
        self.titleOne = titleOne
        self.valueOne = valueOne
        self.titleTwo = titleTwo
        self.valueTwo = valueTwo
        self.titleThree = titleThree
        self.valueThree = valueThree
        self.titleFour = titleFour
        self.valueFour = valueFour
        self.titleFive = titleFive
        self.valueFive = valueFive
        self.titleSix = titleSix
        self.valueSix = valueSix
        self.titleSeven = titleSeven
        self.valueSeven = valueSeven
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(titleOne)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(AppColors.accent)
           
            Text(valueOne)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppColors.secondaryText)
            Divider()
            
            if let titleTwo = titleTwo {
                Text(titleTwo)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueTwo = valueTwo {
                Text(valueTwo)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                Divider()
            }
            
            
            if let titleThree = titleThree {
                Text(titleThree)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueThree = valueThree {
                Text(valueThree)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                Divider()
            }
            
            
            if let titleFour = titleFour {
                Text(titleFour)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueFour = valueFour {
                Text(valueFour)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
            }
            
            if let titleFive = titleFive {
                Divider()
                Text(titleFive)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueFive = valueFive {
                Text(valueFive)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                
            }
            
            
            if let titleSix = titleSix {
                Divider()
                Text(titleSix)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueSix = valueSix {
                Text(valueSix)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
                
            }
            
            
            if let titleSeven = titleSeven {
                Divider()
                Text(titleSeven)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(AppColors.accent)
            }
            if let valueSeven = valueSeven {
                Text(valueSeven)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(AppColors.secondaryText)
            }
            
        }
        .padding(.horizontal, 28)
        .padding(.vertical, 16)
        .statBubbleStyle()
    }
}
