//
//  SSOT.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct SSOT: ViewModifier {
    let appStore: AppStore
    let accountsStore: AccountsStore
    
    public init () {
        appStore = .init()
        accountsStore = .init()
        
        accountsStore.bind(to: appStore)
    }
    
    public func body(content: Content) -> some View {
        content
            .environment(accountsStore)
            .environment(appStore)
    }
}
