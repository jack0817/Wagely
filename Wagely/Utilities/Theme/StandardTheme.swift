//
//  StandardTheme.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct StandardTheme: ThemeProvider {
    public func color(_ themeColor: Theme.Color) -> SwiftUI.Color {
        switch themeColor {
        case .accent:
            Color.blue
        case .background:
            .init("Colors/Standard/background")
        case .backgroundInverse:
            .init("Colors/Standard/background.inverse")
        }
    }
    
    public func font(_ themeFont: Theme.Font) -> SwiftUI.Font {
        switch themeFont {
        case .heading1:
            .title
        case .heading2:
            .title2
        case .heading3:
            .title3
        case .heading4:
            .subheadline
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

#Preview {
    struct Preview: View {
        @Environment(\.theme) private var theme
        
        var body: some View {
            ScrollView {
                VStack(spacing: 32.0) {
                    section(title: "Colors") { colorsContent() }
                    
                    section(title: "Colors - Dark Mode") { colorsContent() }
                        .environment(\.colorScheme, .dark)
                }
                .padding(16.0)
            }
            .background(
                theme.color(.background)
                    .edgesIgnoringSafeArea(.all)
            )
        }
        
        func colorsContent() -> some View {
            VStack(spacing: 16.0) {
                ForEach(Theme.Color.allCases, id: \.self) { themeColor in
                    colorView(for: themeColor)
                }
            }
        }
        
        func section<Content: View>(
            title: String,
            @ViewBuilder content: () -> Content
        ) -> some View {
            VStack {
                Text(title)
                    .font(theme.font(.heading1))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                content()
            }
            .padding(16.0)
            .background {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(.ultraThickMaterial)
            }
        }
        
        func colorView(for themeColor: Theme.Color) -> some View {
            HStack {
                Circle().fill(theme.color(themeColor))
                    .frame(width: 44.0, height: 44.0)
                
                Text(themeColor.debugDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    return Preview()
        .theme(.standard)
}
