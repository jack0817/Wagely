//
//  WagelyShema.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/22/25.
//

import SwiftData

// MARK: V1

public enum WagelyShema_V1: VersionedSchema {
    public static var versionIdentifier: Schema.Version { .init(1, 0, 0) }
    
    public static var models: [any PersistentModel.Type] {
        [WagelyShema_V1.AccountModel.self]
    }
}

// MARK: Migration Plan

public enum WagelyMigrationPlan: SchemaMigrationPlan {
    public static var schemas: [any VersionedSchema.Type] {
        [WagelyShema_V1.self]
    }
    
    public static var stages: [MigrationStage] {
        []
    }
}
