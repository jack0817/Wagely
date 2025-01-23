//
//  DueDateView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct AccountsSummaryView: View {
    @Environment(AccountsStore.self) private var accountsStore
    @Environment(\.theme) private var theme
    
    private var currencyCode: String  {
        Locale.current.currency?.identifier ?? "USD"
    }
    
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
        VStack {
            HStack(alignment: .top) {
                Text(account.name)
                    .font(theme.font(.heading3))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(
                    account.dueDate(from: accountsStore.selectedMonth),
                    format: .dateTime.month(.wide).day().year()
                )
            }
            
            HStack {
                Group {
                    Text(account.hourlyWage, format: .currency(code: currencyCode))
                    + Text("/hr")
                }
                .font(theme.font(.caption))
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
    
    AccountsSummaryView()
        .padding()
        .environment(AccountsStore(previewAccountsState))
}
