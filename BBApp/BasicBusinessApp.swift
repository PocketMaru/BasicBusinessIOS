//
//  BasicBusiness.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/4/25.
//

import SwiftUI

@main
struct BasicBusinessApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .accentColor(ThemeColors.logoColor)
        }
    }
}
