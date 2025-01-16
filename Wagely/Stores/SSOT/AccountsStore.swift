//
//  AccountsStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/15/25.
//

import Foundation
import AsyncStore

public enum AccountsTaskKey: AsyncTaskKey {
    case observe
    case bindToAppStore
    case loadAccounts
    case createDefault
    case loadSummary
}

public struct AccountsState: Equatable {
    public var selectedMonth: Date
    public var accounts: [Account]
    public var monthSummary: MonthSummary
    
    public init(
        selectedMonth: Date = .now.firstOfMonth(),
        accounts: [Account] = [],
        monthSummary: MonthSummary = .empty(.now.firstOfMonth())
    ) {
        self.selectedMonth = selectedMonth
        self.accounts = accounts
        self.monthSummary = monthSummary
    }
}

// MARK: Public API

public typealias AccountsStore = AsyncStore<AccountsTaskKey, AccountsState>

public extension AccountsStore {
    convenience init(_ state: AccountsState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
        receive(.task(observeTask))
        setEnv(\.accounts, to: { [weak self] in self?.accounts ?? [] })
    }
    
    func bind(to appStore: AppStore) {
        receive(.task(param: appStore, bindToAppStoreTask))
    }
}

// MARK: Tasks

fileprivate extension AccountsStore {
    func observeTask() async throws -> Effect {
        await bind(
            key: .observe,
            to: \.selectedMonth,
            map: mapSelectedMonth
        )
        return .none
    }
    
    func bindToAppStoreTask(to appStore: AppStore) async throws -> Effect {
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
    
    func createDefaultAccountIfNeeded() async throws -> Effect {
        guard state.accounts.isEmpty else { return .none }
        
        let newAccount = Account.defaultAccount
        try await env.persistence.insert(newAccount)
        return .set(\.accounts, to: [newAccount])
    }
    
    func loadSummaryTask() async throws -> Effect {
        let summary = await env.summaryService.summary(
            for: state.selectedMonth,
            accounts: state.accounts
        )
        return .set(\.monthSummary, to: summary)
    }
}

// MARK: Effects

fileprivate extension AccountsStore {
    @Sendable func mapAppIsInitialized(_ isAppInitialized: Bool) -> Effect {
        guard isAppInitialized else { return .none }
        return .concatenate(
            .task(.loadAccounts, loadAccountsTask),
            .task(.createDefault, createDefaultAccountIfNeeded),
            .task(.loadSummary, loadSummaryTask)
        )
    }
    
    @Sendable func mapSelectedMonth(_ selectedMonth: Date) -> Effect {
        return .task(.loadSummary, loadSummaryTask)
    }
}

// MARK: Error Handling

fileprivate extension AccountsStore {
    struct ErrorHandler {
        func handle(_ error: Error) -> Effect {
            Log.error("[AccountsStore] \(error)")
            return .none
        }
    }
}

// MARK: AsyncStore Environment

enum AccountsEnvironmentKey: AsyncStoreEnvironmentKey {
    static var defaultValue: () async -> [Account] { { [] } }
}

public extension AsyncStoreEnvironmentValues {
    var accounts: () async -> [Account] {
        get { self[AccountsEnvironmentKey.self] }
        set { self[AccountsEnvironmentKey.self] = newValue }
    }
}

