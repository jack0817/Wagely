//
//  AppView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct AppView: View {
    @Environment(AppStore.self) private var appStore
    
    var body: some View {
        TabView(selection: .constant(appStore.selectedTab)) {
            ForEach(appStore.tabs) { tab in
                Tab(
                    tab.title,
                    systemImage: tab.systemImageName,
                    value: tab
                ) {
                    view(for: tab)
                }
            }
        }
    }
    
    @ViewBuilder func view(for tab: AppTab) -> some View {
        switch tab {
        case .home:
            HomeView()
        case .settings:
            SettingsView()
        }
    }
}

#Preview {
    AppView()
        .environment(AppStore())
}
