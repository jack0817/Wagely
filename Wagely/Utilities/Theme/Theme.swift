//
//  Theme.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

protocol ThemeProvider {
    func color(_ themeColor: Theme.Color) -> SwiftUI.Color
    func font(_ themeFont: Theme.Font) -> SwiftUI.Font
}

struct Theme {
    let provider: ThemeProvider
    
    init(_ provider: ThemeProvider) {
        self.provider = provider
    }
    
    func color(_ themeColor: Color) -> SwiftUI.Color {
        provider.color(themeColor)
    }
    
    func font(_ themeFont: Font) -> SwiftUI.Font {
        provider.font(themeFont)
    }
}

// MARK: Colors

extension Theme {
    enum Color {
        case accent
        case background
        case backgroundInverse
    }
}

// MARK: Fonts

extension Theme {
    enum Font {
        case heading1
        case heading2
        case heading3
        case body
        case action
        case caption
    }
}

// MARK: SwiftUI Environment

enum ThemeEnvironmentKey: EnvironmentKey {
    static var defaultValue: Theme { .init(.standard) }
}

extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }
}

extension View {
    func theme(_ provider: ThemeProvider) -> some View {
        environment(\.theme, .init(provider))
    }
}
