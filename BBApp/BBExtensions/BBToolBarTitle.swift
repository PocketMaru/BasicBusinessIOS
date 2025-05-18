//
//  LPToolBarTitle.swift
//  LawnPro
//
//  Created by Joshua Hauer on 5/9/25.
//

import SwiftUI

extension View {
    func BBToolBarTitle(action: @escaping () -> Void) -> some View {
        self.toolbar {
            ToolbarItem(placement:.topBarLeading) {
                VStack{
                    HStack {
                        Text("BasicBusiness")
                            .font(.system(size: 32,weight: .bold))
                            .foregroundStyle(BBColor.logoColor)
                        Image(systemName:"gear")
                            .foregroundStyle(BBColor.logoColor).font(.title.bold())
                    }
                }
            }
        }
        .foregroundColor(BBColor.logoColor)
        .scrollContentBackground(.hidden)
        .background(BBColor.backgroundColor)
    }
}


