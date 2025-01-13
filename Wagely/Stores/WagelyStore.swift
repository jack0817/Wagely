//
//  WagelyStore.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation
import AsyncStore

public enum WagelyTaskKey: AsyncTaskKey {
    case loadWages
}

public struct WagelyState {
    var selectedMonth: Date
    
    public init(selectedMonth: Date = .now.firstOfMonth()) {
        self.selectedMonth = selectedMonth
    }
}

public typealias WagelyStore = AsyncStore<WagelyTaskKey, WagelyState>

public extension WagelyStore {
    convenience init(_ state: WagelyState = .init()) {
        self.init(state, mapError: ErrorHandler().handle)
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
