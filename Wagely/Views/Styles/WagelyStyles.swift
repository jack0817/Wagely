//
//  WagelyStyles.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

// MARK: WagelyLabelStyle

public struct WagelyLabelStyle: LabelStyle {
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
                .frame(maxWidth: .infinity, alignment: .leading)
            
            configuration.icon
        }
    }
}

// MARK: Primary Button Style

public struct WagelyPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.theme) private var theme
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.font(.action))
            .foregroundStyle(theme.color(.background))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 16.0)
            .frame(height: 44.0)
            .background {
                RoundedRectangle(cornerRadius: 22.0).fill(theme.color(.accent))
            }
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

public extension ButtonStyle where Self == WagelyPrimaryButtonStyle {
    static var primary: Self { WagelyPrimaryButtonStyle() }
}

// MARK: Secondary Button Style

public struct WagelySecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.theme) private var theme
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(theme.font(.action))
            .foregroundStyle(theme.color(.accent))
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal, 16.0)
            .frame(height: 44.0)
            .background {
                RoundedRectangle(cornerRadius: 22.0)
                    .stroke(theme.color(.accent), lineWidth: 2.0)
                    .padding(1.0)
            }
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

public extension ButtonStyle where Self == WagelySecondaryButtonStyle {
    static var secondary: Self { WagelySecondaryButtonStyle() }
}

// MARK: WagelyStylesModifier

private struct WagelyStylesModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelStyle(WagelyLabelStyle())
    }
}

public extension View {
    func wagelyStyles() -> some View {
        self.modifier(WagelyStylesModifier())
    }
}

// MARK: Previews

#Preview {
    ScrollView {
        VStack {
            Button("Primary") {}
                .buttonStyle(.primary)
            
            Button("Secondary") {}
                .buttonStyle(.secondary)
        }
        .padding()
    }
}
