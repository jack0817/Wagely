//
//  SharedDataStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import AsyncStore

public enum SharedDataKey: AsyncTaskKey {
    case load
}

public struct SharedDataState {
    public init() {
        
    }
}

public typealias SharedDataStore = AsyncStore<SharedDataKey, SharedDataState>

// MARK: Public API

public extension SharedDataStore {
    convenience init(_ state: SharedDataState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
    }
}

// MARK: Tasks / Effects

fileprivate extension SharedDataStore {

}

// MARK: Error Handling

fileprivate extension SharedDataStore {
    struct ErrorHandler {
        func handle(_ error: Error) -> Effect {
            print("[SharedDataStore] error \(error)")
            return .none
        }
    }
}

// MARK: Tasks / Effects

fileprivate extension SharedDataStore {
    static let shared = SharedDataStore()
}

// MARK: AsyncStore Environment

enum SharedDataStoreEnvironmentKey: AsyncStoreEnvironmentKey {
    static var defaultValue: SharedDataStore { .shared }
}

public extension AsyncStoreEnvironmentValues {
    var sharedData: SharedDataStore {
        get { self[SharedDataStoreEnvironmentKey.self] }
    }
}
