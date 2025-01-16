//
//  Account.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/15/25.
//

import Foundation
import SwiftData

public struct Account: Equatable {
    let appId: String
    let name: String
    let dateCreated: Date
    let workDays: [Int]
    let hoursPerDay: Double
    let hourlyWage: Double
    
    public init(
        name: String,
        dateCreated: Date,
        workDays: [Int],
        hoursPerDay: Double,
        hourlyWage: Double
    ) {
        self.appId = UUID().uuidString
        self.name = name
        self.dateCreated = dateCreated
        self.workDays = workDays
        self.hoursPerDay = hoursPerDay
        self.hourlyWage = hourlyWage
    }
}

extension Account: Identifiable {
    public var id: String { appId }
}

extension Account: Persistable {
    public typealias Model = AccountModel
    
    public init(model: AccountModel) {
        self.appId = model.appId
        self.name = model.name
        self.dateCreated = model.dateCreated
        self.workDays = model.workDays
        self.hoursPerDay = model.hoursPerDay
        self.hourlyWage = model.hourlyWage
    }
    
    public func model() async throws -> AccountModel {
        Model(
            appId: appId,
            name: name,
            dateCreated: dateCreated,
            workDays: workDays,
            hoursPerDay: hoursPerDay,
            hourlyWage: hourlyWage
        )
    }
}

public extension Account {
    static var defaultAccount: Account {
        Account(
            name: "New Account",
            dateCreated: .now,
            workDays: .defaultWorkDays,
            hoursPerDay: 8.0,
            hourlyWage: 130.0
        )
    }
}

fileprivate extension [Int] {
    static var defaultWorkDays: [Int] {
        [2, 3, 4, 5, 6]
    }
}
