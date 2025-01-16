//
//  DueDateView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct DueDateView: View {
    @Environment(AccountsStore.self) private var accountsStore
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(spacing: 8.0) {
            Text("Due Dates")
                .font(theme.font(.heading3).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(accountsStore.accounts) { account in
                lineItemView(for: account)
            }
        }
    }
    
    func lineItemView(for account: Account) -> some View {
        HStack(alignment: .top) {
            Text(account.name)
                .font(theme.font(.heading3))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .trailing) {
                Text(
                    account.dueDate(from: accountsStore.selectedMonth),
                    format: .dateTime.month(.wide).day().year()
                )
                
                Text(account.billing.title)
                    .font(theme.font(.caption))
            }
        }
        .font(theme.font(.body))
    }
}

#Preview {
    let previewAccountsState = AccountsState(
        accounts: [.defaultAccount]
    )
    
    DueDateView()
        .padding()
        .environment(AccountsStore(previewAccountsState))
}
