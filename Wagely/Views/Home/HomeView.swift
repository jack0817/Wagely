//
//  HomeView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(AccountsStore.self) private var accountsStore
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
                    selectedMonth: accountsStore.binding(for: \.selectedMonth),
                    in: geo.size
                )
                
                MonthSummaryView(summary: accountsStore.monthSummary)
                    .padding(16.0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.easeInOut, value: accountsStore.selectedMonth)
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
        .environment(AccountsStore())
}
