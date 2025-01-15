//
//  HomeNavigationStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import AsyncStore

public enum HomeNavigationKey: AsyncTaskKey {
    case navigate
}

public struct HomeNavigationState {
    public var stack: [HomeNavigationItem]
    public var presentedSheetItem: HomePresentedSheetItem? = .none
    
    public init(stack: [HomeNavigationItem] = []) {
        self.stack = stack
    }
}

public typealias HomeNavigationStore = AsyncStore<HomeNavigationKey, HomeNavigationState>

// MARK: Public API

public extension HomeNavigationStore {
    convenience init(_ state: HomeNavigationState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
    }
    
    func navigate(to dest: HomeNavigationItem) {
        receive(.set({ state in
            state.stack.append(dest)
        }))
    }
    
    func back() {
        receive(.set({ state in
            guard !state.stack.isEmpty else { return }
            state.stack.removeLast()
        }))
    }
    
    func back(to dest: HomeNavigationItem) {
        receive(.set({ state in
            guard let index = state.stack.lastIndex(of: dest) else { return }
            state.stack = Array(state.stack[0 ..< index])
        }))
    }
    
    func backToRoot() {
        receive(.set({ state in
            state.stack = []
        }))
    }
    
    func present(_ item: HomePresentedSheetItem) {
        receive(.set({ state in
            state.presentedSheetItem = item
        }))
    }
    
    func dismiss() {
        receive(.set({ state in
            state.presentedSheetItem = .none
        }))
    }
}

// MARK: Tasks / Effects

fileprivate extension HomeNavigationStore {
}

// MARK: Error Handling

fileprivate extension HomeNavigationStore {
    struct ErrorHandler {
        func handle(_ error: Error) -> Effect {
            Log.error("[HomeNavigationStore] \(error)")
            return .none
        }
    }
}
