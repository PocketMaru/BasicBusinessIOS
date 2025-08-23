//
//  BindingExtension .swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/23/25.
//

import Foundation
import SwiftUI

extension Binding where Value == String? {
    func defaulting(to defaultValue: String) -> Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 }
        )
    }
}
