//
//  IfExtension.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 7/2/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
