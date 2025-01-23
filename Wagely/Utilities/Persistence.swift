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
        
        do {
            let container = try ModelContainer(
                for: .init(versionedSchema: WagelySchema.self),
                migrationPlan: WagelyMigrationPlan.self
            )
            
            self.executor = DefaultSerialModelExecutor(modelContext: .init(container))
            Log.info("Persistence inialized")
        } catch {
            guard !Runtime.isPreviews else { return }
#if DEBUG
            fatalError("Could not create ModelContainer: \(error)")
#else
            Log.error("Persistence error \(error)")
#endif
        }
    }
    
    public func save() async throws {
        guard let executor else { throw Error.notInitialized }
        try executor.modelContext.save()
    }
    
    public func insert<P: Persistable>(_ P: P) async throws {
        guard let context = executor?.modelContext else { throw Error.notInitialized }
        await context.insert(try P.model())
        try await save()
    }
    
    public func fetch<P: Persistable>(
        _ modelType: P.Type,
        where predicate: Predicate<P.Model> = .true
    ) async throws -> [P] {
        guard let context = executor?.modelContext else { throw Error.notInitialized }
        
        let descriptor = FetchDescriptor<P.Model>(predicate: predicate)
        let models = try context.fetch(descriptor)
        return try models.map { try P(model: $0) }
    }
}

public extension Persistence {
    enum Error: Swift.Error {
        case alreadyInitiallyized
        case notInitialized
    }
}

// Persistable

public protocol Persistable {
    associatedtype Model: PersistentModel
    
    init(model: Model) throws
    func model() async throws -> Model
}

// AsyncStore Environment

public enum PersistenceEnvironmentKey: AsyncStoreEnvironmentKey {
    public static var defaultValue: Persistence { Persistence.shared }
}

public extension AsyncStoreEnvironmentValues {
    var persistence: Persistence { self[PersistenceEnvironmentKey.self] }
}
