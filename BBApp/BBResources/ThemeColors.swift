//
//  LPAppColors.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/6/25.
//

import SwiftUI

final class ThemeColors {
    private init() {}
    static let logoColor: Color = Color(red: 26/255,green:150/255,blue: 100/255)
    static let backgroundColor: Color = Color(red:240/255,green:245/255,blue:240/255)
    static let someColor: Color = Color("backgroundColor")
}

enum AppColors {
    static let bg = Color("PrimaryBackground")
    static let card = Color("SectionCardBG")
    static let text = Color("TextPrimary")
    static let secondaryText = Color("TextSecondary")
    static let accent = Color("PrimaryAccent")
    static let error = Color("ErrorBackground")
    static let success = Color("SuccessBackground")
}
