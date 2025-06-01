//
//  Theme.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public protocol ThemeProvider {
    func color(_ themeColor: Theme.Color) -> SwiftUI.Color
    func font(_ themeFont: Theme.Font) -> SwiftUI.Font
}

public struct Theme {
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

public extension Theme {
    enum Color: CaseIterable, Hashable {
        case accent
        case background
        case backgroundInverse
    }
}

extension Theme.Color: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .accent:
            return "Accent"
        case .background:
            return "Background"
        case .backgroundInverse:
            return "Background Inverse"
        }
    }
}

// MARK: Fonts

public extension Theme {
    enum Font: CaseIterable, Hashable {
        case heading1
        case heading2
        case heading3
        case heading4
        case body
        case action
        case caption
    }
}

extension Theme.Font: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .heading1:
            return "Heading 1"
        case .heading2:
            return "Heading 2"
        case .heading3:
            return "Heading 3"
        case .heading4:
            return "Heding 4"
        case .body:
            return "Body"
        case .action:
            return "Action"
        case .caption:
            return "Caption"
        }
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
