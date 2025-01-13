//
//  SSOT.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct SSOT: ViewModifier {
    let appStore: AppStore
    let wagelyStore: WagelyStore
    
    public init () {
        appStore = .init()
        wagelyStore = .init()
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(wagelyStore)
            .environment(appStore)
    }
}
