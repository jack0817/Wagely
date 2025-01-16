//
//  AccountSummaryDetailsView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct AccountSummaryDetailsView: View {
    @Environment(AccountsStore.self) private var accountsStore
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AccountSummaryDetailsView()
        .environment(AccountsStore())
}
