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
            MainTabView(
                customerListVM: CustomerListVM(customer: CustomerModel.sampleList ),
                customerDetailVM: CustomerDetailVM(customer: CustomerModel.sample),
                quoteVM: QuoteVM(savedMaterials: <#[MaterialModel]#>),
                materialVM: MaterialVM(materials: <#[MaterialModel]#>)
            )
                .accentColor(ThemeColors.logoColor)
        }
    }
}
