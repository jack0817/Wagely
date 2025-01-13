//
//  HomeView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(WagelyStore.self) private var wagelyStore
    @Environment(\.theme) private var theme
    @State private var homeNavStore = HomeNavigationStore()
    
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
        GeometryReader { geo in
            VStack {
                MonthSelectorView(
                    selectedMonth: wagelyStore.binding(for: \.selectedMonth),
                    in: geo.size
                )
                
                Button("Test Presentation") {
                    homeNavStore.present(.congrats)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.easeInOut, value: wagelyStore.selectedMonth)
        }
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
        .environment(WagelyStore())
}
