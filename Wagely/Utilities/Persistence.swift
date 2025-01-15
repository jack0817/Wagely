//
//  Persistence.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation
import SwiftData
import AsyncStore

public final actor Persistence {
    public static let shared = Persistence()
    
    private var executor: DefaultSerialModelExecutor? = .none
    private var context: ModelContext? { executor?.modelContext }
    
    private init() {}
    
    public func initializeDatabase() async throws {
        guard executor == nil else { throw Error.alreadyInitiallyized }
        
        let schema = Schema([
            Account.self,
        ])
        
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.executor = DefaultSerialModelExecutor(modelContext: .init(container))
            Log.info("Persistence inialized")
        } catch {
#if DEBUG
            fatalError("Could not create ModelContainer: \(error)")
#else
            Log.error("Persistence error \(error)")
#endif
        }
    }
    
    public func fetch<Model: PersistentModel>(_ model: Model.Type) async throws -> [Model] {
        guard let executor else { throw Error.notInitialized }
        let descriptor = FetchDescriptor<Model>()
        return try executor.modelContext.fetch(descriptor)
    }
}

public extension Persistence {
    enum Error: Swift.Error {
        case alreadyInitiallyized
        case notInitialized
    }
}

// AsyncStore Environment

public enum PersistenceEnvironmentKey: AsyncStoreEnvironmentKey {
    public static var defaultValue: Persistence { Persistence.shared }
}

public extension AsyncStoreEnvironmentValues {
    var persistence: Persistence { self[PersistenceEnvironmentKey.self] }
}
