//
//  SSOT.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct SSOT: ViewModifier {
    let appStore: AppStore
    
    public init () {
        appStore = .init()
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(appStore)
    }
}
