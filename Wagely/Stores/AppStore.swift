//
//  AppStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import AsyncStore

// MARK: Task Key

public enum AppStoreKey: AsyncTaskKey {
    case initializeApp
}

// MARK: State

public struct AppState {
    public var tabs: [AppTab] = [.home, .settings]
    public var selectedTab: AppTab? = .none
    
    public init() {
        
    }
}

// MARK: Store

public typealias AppStore = AsyncStore<AppStoreKey, AppState>

// MARK: Public API

public extension AppStore {
    convenience init(_ state: AppState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
    }

    func initializeApp() {
        receive(
            .task(.initializeApp, initializeApp)
        )
    }
}

// MARK: Tasks / Effects

fileprivate extension AppStore {
    func initializeApp() async throws -> Effect {
        return .none
    }
}

// MARK: Error Handling

fileprivate extension AppStore {
    struct ErrorHandler {
        func handle(_ error: Error) -> Effect {
            .none
        }
    }
}
