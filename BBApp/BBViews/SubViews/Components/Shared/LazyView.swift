//
//  LazyView.swift
//  BasicBusiness
//
//  Created by Joshua Hauer on 8/21/25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    var body: some View { build() }
}
