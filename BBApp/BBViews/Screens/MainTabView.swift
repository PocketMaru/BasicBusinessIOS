//
//  TabView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 6/6/25.
//

import SwiftUI

struct MainTabView: View {
    var customer: CustomerModel?
    var body: some View {
        
        TabView {
            BusinessStatsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Business Stats")
                }
        }
       
    }
}
