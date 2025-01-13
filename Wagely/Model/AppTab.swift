//
//  AppTab.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public enum AppTab {
    case home
    case settings
}

public extension AppTab {
    var title: String {
        switch self {
        case .home: return "Home"
        case .settings: return "Settings"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .home: return "house"
        case .settings: return "gearshape"
        }
    }
}

extension AppTab: Identifiable {
    public var id: String { title }
}
