//
//  LPToolBarTitle.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/9/25.
//

import SwiftUI

extension View {
    func ToolBarTitle(action: @escaping () -> Void) -> some View {
        self.toolbar {
            ToolbarItem(placement:.topBarLeading) {
                VStack{
                    HStack {
                        Text("BasicBusiness")
                            .font(.system(size: 32,weight: .bold))
                            .foregroundStyle(ThemeColors.logoColor)
                        Image(systemName:"gear")
                            .foregroundStyle(ThemeColors.logoColor).font(.title.bold())
                    }
                }
            }
        }
        .foregroundColor(ThemeColors.logoColor)
        .scrollContentBackground(.hidden)
        .background(ThemeColors.backgroundColor)
    }
}


