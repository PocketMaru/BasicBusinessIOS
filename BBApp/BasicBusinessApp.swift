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
/// - `QuoteVM`
/// - `MaterialVM`
/// Applies `.accentColor(ThemeColors.logoColor)` to tint controls app-wide via view hierarchy inheritance.
@main
struct BasicBusinessApp: App {
    var body: some Scene {
        WindowGroup {
            
            let fileStorage = FileStorageManager()
            let saveCustomer = SaveCustomer(fileStorage: fileStorage)
            
            let listVM = CustomerListVM(
                saveCustomer: saveCustomer,
                customerListStorage: fileStorage
            )
            
            MainTabView(
                customerListVM: listVM,
                quoteVM: QuoteVM(savedMaterials: MaterialModel.sampleList),
                materialVM: MaterialVM(materials: MaterialModel.sampleList)
            )
                .accentColor(ThemeColors.logoColor)
        }
    }
}
