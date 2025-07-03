//
//  BasicBusiness.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 5/4/25.
//

import SwiftUI
/// Entry point for the Basic Business app.
/// Injects shared view models into `MainTabView`
/// - `CustomerListVM`
/// - `CustomerDetailVM`
/// - `QuoteVM`
/// - `MaterialVM`
/// Applies `.accentColor(ThemeColors.logoColor)` to tint controls app-wide via view hierarchy inheritance.
@main
struct BasicBusinessApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView(
                customerListVM: CustomerListVM(),
                customerDetailVM: CustomerDetailVM(customer: CustomerModel.sample),
                quoteVM: QuoteVM(savedMaterials: MaterialModel.sampleList),
                materialVM: MaterialVM(materials: MaterialModel.sampleList)
            )
                .accentColor(ThemeColors.logoColor)
        }
    }
}
