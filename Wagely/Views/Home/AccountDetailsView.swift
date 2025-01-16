//
//  AccountDetailsView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct AccountDetailsView: View {
    @Environment(AccountsStore.self) private var accountsStore
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack {
            Text(accountsStore.selectedMonth, format: .dateTime.month().year())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16.0)
                .font(theme.font(.heading2))
            
            List {
                ForEach(accountsStore.accounts) { account in
                    CardView(account: account)
                }
            }
            .navigationTitle("Accounts")
        }
    }
}

extension AccountDetailsView {
    struct CardView: View {
        let account: Account
        
        @Environment(AccountsStore.self) private var accountsStore
        
        var body: some View {
            HStack(alignment: .top) {
                Text(account.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .trailing) {
                    Text("Due: ")
                        + Text(
                            account.dueDate(from: accountsStore.selectedMonth),
                            format: .dateTime.month().day().year()
                        )
                    
                    Text(account.billing.title)
                }
            }
        }
    }
}

fileprivate extension Account {
    func dueDate(from month: Date) -> Date {
        month.lastOfMonth().add(days: billing.days)
    }
}

#Preview {
    let previewAccountsState = AccountsState(
        accounts: [.defaultAccount]
    )
    
    NavigationStack {
        AccountDetailsView()
    }
    .environment(AccountsStore(previewAccountsState))
}
