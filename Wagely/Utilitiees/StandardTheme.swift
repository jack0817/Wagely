//
//  StandardTheme.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct StandardTheme: ThemeProvider {
    func color(_ themeColor: Theme.Color) -> SwiftUI.Color {
        switch themeColor {
        case .background:
            .white
        }
    }
    
    func font(_ themeFont: Theme.Font) -> SwiftUI.Font {
        switch themeFont {
        case .body:
                .body
        }
    }
}

extension ThemeProvider where Self == StandardTheme {
    static var standard: Self { StandardTheme() }
}
