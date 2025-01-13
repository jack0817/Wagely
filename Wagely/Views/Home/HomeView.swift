//
//  HomeView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct HomeView: View {
    @State private var homeNavStore = HomeNavigationStore()
    @Environment(\.theme) private var theme
    
    var body: some View {
        NavigationStack(path: homeNavStore.binding(for: \.stack)) {
            mainContent()
                .navigationDestination(
                    for: HomeNavigationItem.self,
                    destination: destinationView
                )
                .sheet(
                    item: homeNavStore.binding(for: \.presentedSheetItem),
                    content: presentedView
                )
        }
    }
    
    func mainContent() -> some View {
        VStack {
            GeometryReader { geo in
                Color.white
            }
            .frame(height: 200.0)
            
            Button("Test Presentation") {
                homeNavStore.present(.congrats)
            }
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(theme.color(.background).edgesIgnoringSafeArea(.all))
        .navigationTitle("Wagely")
    }
    
    @ViewBuilder func destinationView(for item: HomeNavigationItem) -> some View {
        switch item {
        case .details:
            Text("Details")
        }
    }
    
    @ViewBuilder func presentedView(for item: HomePresentedSheetItem) -> some View {
        switch item {
        case .congrats:
            VStack {
                Text("Contgrats")
                Button("Dismiss") { homeNavStore.dismiss() }
            }
        }
    }
}

#Preview {
    HomeView()
        .background(Theme(.standard).color(.background))
}
