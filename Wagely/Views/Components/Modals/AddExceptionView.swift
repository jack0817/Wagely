//
//  AddExceptionView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/20/25.
//

import SwiftUI

struct AddExceptionView: View {
    let day: Date
    
    @Environment(AccountsStore.self) private var accountsStore
    @Environment(HomeNavigationStore.self) private var navStore
    @Environment(\.theme) private var theme
    @State private var selectedAccount: Account? = .none
    @State private var viewState = ViewState()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32.0) {
                accountsView()
                
                textFieldsView()
                
                Button("Add") {  }
                    .buttonStyle(.primary)
            }
            .padding(16.0)
            .frame(maxHeight: .infinity, alignment: .top)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(
                        action: { navStore.dismiss() },
                        label: { Image(systemName: "xmark") }
                    )
                }
            }
            .onAppear {
                guard let firstAccount = accountsStore.accounts.first else { return }
                selectedAccount = firstAccount
                viewState.hourlyWage = firstAccount.hourlyWage
                viewState.hours = firstAccount.hoursPerDay
            }
            .navigationTitle("Add Exception")
        }
    }
    
    @ViewBuilder private func accountsView() -> some View {
        VStack {
            if accountsStore.accounts.count > 1 {
                Menu {
                    Picker("Account", selection: $selectedAccount) {
                        ForEach(accountsStore.accounts) { account in
                            Text(account.name)
                                .font(theme.font(.heading2).bold())
                                .tag(account)
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedAccount?.name ?? "")
                        Image(systemName: "chevron.down")
                    }
                    .font(theme.font(.heading2).weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            } else if let account = accountsStore.accounts.first {
                Text(account.name)
                    .font(theme.font(.heading2).weight(.semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(day, format: .dateTime)
                .font(theme.font(.body).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func textFieldsView() -> some View {
        VStack(spacing: 16.0) {
            Text("Overrides")
                .font(theme.font(.heading3).weight(.semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            textFieldView("Hourly Wage", for: \.hourlyWage)
            textFieldView("Hours", for: \.hours)
        }
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.decimalPad)
    }
    
    fileprivate func textFieldView(
        _ title: String,
        for keyPath: WritableKeyPath<ViewState, Double>
    ) -> some View {
        HStack(spacing: 32.0) {
            Text(LocalizedStringKey(title))
            
            switch keyPath {
            case \.hourlyWage:
                TextField("", value: $viewState.hourlyWage, format: .number)
            case \.hours:
                TextField("", value: $viewState.hours, format: .number)
            default:
                EmptyView()
            }
            
            Text("Hours")
        }
    }
}

fileprivate extension AddExceptionView {
    struct ViewState {
        var hourlyWage: Double
        var hours: Double
        
        init(hourlyWage: Double = 0.0, hours: Double = 0.0) {
            self.hourlyWage = hourlyWage
            self.hours = hours
        }
    }
}

#Preview {
    let accountsState = AccountsState(
        accounts: [
            .preview(id: "01"),
            .preview(id: "02"),
            .preview(id: "03")
        ]
    )
    
    return AddExceptionView(day: .now)
        .environment(AccountsStore(accountsState))
        .environment(HomeNavigationStore())
}
