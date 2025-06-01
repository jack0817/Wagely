//
//  AppStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import AsyncStore

// MARK: Task Key

public enum AppStoreKey: Hashable {
    case initializeApp
}

// MARK: State

public struct AppState {
    public var isAppInitialized: Bool
    public var tabs: [AppTab]
    public var selectedTab: AppTab
    
    public init(
        isAppInitialized: Bool = false,
        tabs: [AppTab] = [.home, .settings],
        selectedTab: AppTab = .home
    ) {
        self.isAppInitialized = isAppInitialized
        self.tabs = tabs
        self.selectedTab = selectedTab
    }
}

// MARK: Store

public typealias AppStore = AsyncStore<AppState, AppStoreKey>

// MARK: Public API

public extension AppStore {
    convenience init(state: AppState = .init()) {
        self.init(state)
        self.errorHandler = { _ in .none }
    }

    func initializeApp() {
        run(.task(.initializeApp, initializeApp))
    }
}

// MARK: Tasks / Effects

fileprivate extension AppStore {
    func initializeApp() async throws -> Effect {
        setLogLevel()
        try await env.persistence.initializeDatabase()
        return .set(\.isAppInitialized, to: true)
    }
    
}

// MARK: Error Handling

fileprivate extension AppStore {
    func handle(_ error: Error) -> Effect {
        return .none
    }
}

// MARK: Utilities

fileprivate extension AppStore {
    func setLogLevel() {
#if DEBUG
        Log.setLevel(to: .info)
#else
        Log.setLevel(to: .debug)
#endif
    }
}
