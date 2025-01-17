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
    @State private var navStore = HomeNavigationStore()
    @AppStorage(AppStorageKey.homeSummaryIsCollapsed.rawValue) private var isSummaryCollapsed = false
    
    var body: some View {
        NavigationStack(path: navStore.binding(for: \.stack)) {
            mainContent()
                .navigationDestination(
                    for: HomeNavigationItem.self,
                    destination: destinationView
                )
                .sheet(
                    item: navStore.binding(for: \.presentedSheetItem),
                    content: presentedView
                )
        }
    }
    
    func mainContent() -> some View {
        GeometryReader { geo in
            VStack(spacing: 32.0) {
                MonthSelectorView(
                    selectedMonth: accountsStore.binding(for: \.selectedMonth),
                    in: geo.size
                ) { dayState(for: $0) }
                
                ScrollView {
                    VStack(spacing: 32.0) {
                        MonthSummaryView(
                            summary: accountsStore.monthSummary,
                            isCollapsed: $isSummaryCollapsed
                        )
                        
                        DueDateView()
                    }
                    .padding(.horizontal, 16.0)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.easeInOut, value: accountsStore.selectedMonth)
            .animation(.easeOut, value: isSummaryCollapsed)
        }
        .background(theme.color(.background).edgesIgnoringSafeArea(.all))
        .navigationTitle("Wagely")
    }
    
    @ViewBuilder func destinationView(for item: HomeNavigationItem) -> some View {
        switch item {
        case .accountSummaryDetails:
            Text("Comin Soon")
        }
    }
    
    @ViewBuilder func presentedView(for item: HomePresentedSheetItem) -> some View {
        switch item {
        case .congrats:
            VStack {
                Text("Congrats")
                Button("Dismiss") { navStore.dismiss() }
            }
        }
    }
}

extension HomeView {
    func dayState(for day: Date) -> MonthView.DayState {
        accountsStore.accounts.contains { $0.isWorkDay(day) } ? .workDay : .none
    }
}

#Preview {
    let previewState = AccountsState(
        selectedMonth: .now.firstOfMonth(),
        accounts: [.defaultAccount]
    )
    
    HomeView()
        .environment(AccountsStore(previewState))
        .wagelyStyles()
}
