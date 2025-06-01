//
//  WagelySchema.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/22/25.
//

import SwiftData

// MARK: V1

public enum WagelySchema_V1: VersionedSchema {
    public static var versionIdentifier: Schema.Version { .init(1, 0, 0) }
    
    public static var models: [any PersistentModel.Type] {
        [WagelySchema_V1.AccountModel.self]
    }
}

// MARK: V2

public enum WagelySchema_V2: VersionedSchema {
    public static var versionIdentifier: Schema.Version { .init(2, 0, 0) }
    
    public static var models: [any PersistentModel.Type] {
        [WagelySchema_V1.AccountModel.self]
    }
}

public typealias WagelySchema = WagelySchema_V1

// MARK: Migration Plan

public enum WagelyMigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [WagelySchema_V1.self]
    }
    
    public static var stages: [MigrationStage] {
        []
    }
    
//    static let migrateV1toV2 = MigrationStage.custom(
//        fromVersion: WagelySchema_V1.self,
//        toVersion: UsersSchemaV2.self,
//        willMigrate: { context in
//            // remove duplicates then save
//        }, didMigrate: { context in
//        }
//    )
}
