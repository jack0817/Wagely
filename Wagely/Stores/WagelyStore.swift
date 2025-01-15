//
//  WagelyStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation
import AsyncStore

public enum WagelyTaskKey: AsyncTaskKey {
    case bindToAppStore
    case loadWages
    case loadAccounts
}

public struct WagelyState {
    var selectedMonth: Date
    var accounts: [Account]
    
    public init(
        selectedMonth: Date = .now.firstOfMonth(),
        accounts: [Account] = []
    ) {
        self.selectedMonth = selectedMonth
        self.accounts = accounts
    }
}

// MARK: Public API

public typealias WagelyStore = AsyncStore<WagelyTaskKey, WagelyState>

public extension WagelyStore {
    convenience init(_ state: WagelyState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
    }
    
    func bind(to appStore: AppStore) {
        receive(.task(param: appStore, bindToAppStoreTask))
    }
    
    func loadAccounts() {
        receive(.task(id: .loadAccounts, loadAccountsTask))
    }
}

// MARK: Private API

fileprivate extension WagelyStore {
    func bindToAppStoreTask(_ appStore: AppStore) async throws -> Effect {
        await bind(
            key: .bindToAppStore,
            to: appStore,
            on: \.isAppInitialized,
            map: mapAppIsInitialized
        )
        
        return .none
    }
    
    func loadAccountsTask() async throws -> Effect {
        let accounts = try await env.persistence.fetch(Account.self)
        return .set(\.accounts, to: accounts)
    }
}

// MARK: Effect Mapping

fileprivate extension WagelyStore {
    @Sendable func mapAppIsInitialized(_ appIsInitialized: Bool) -> Effect {
        guard appIsInitialized else { return .none }
        return .task(.loadAccounts, loadAccountsTask)
    }
}

// MARK: Error Handling

fileprivate extension WagelyStore {
    struct ErrorHandler {
        func handle(_ error: Error) -> Effect {
            print("[WagelyStore] \(error)")
            return .none
        }
    }
}
