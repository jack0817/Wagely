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
        case .accent:
            Color.blue
        case .background:
            .init("Colors/Standard/background")
        case .backgroundInverse:
            .init("Colors/Standard/background.inverse")
        }
    }
    
    func font(_ themeFont: Theme.Font) -> SwiftUI.Font {
        switch themeFont {
        case .heading1:
            .title
        case .heading2:
            .title2
        case .heading3:
            .title3
        case .body:
            .body
        case .action:
            .headline.weight(.bold)
        case .caption:
            .caption
        }
    }
}

extension ThemeProvider where Self == StandardTheme {
    static var standard: Self { StandardTheme() }
}
