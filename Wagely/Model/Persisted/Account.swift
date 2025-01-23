//
//  Account.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/15/25.
//

import Foundation
import SwiftData

public struct Account: Equatable, Hashable {
    let appId: String
    let name: String
    let dateCreated: Date
    let workDays: [Int]
    let hoursPerDay: Double
    let hourlyWage: Double
    let billing: Billing
    
    public init(
        appId: String = UUID().uuidString,
        name: String,
        dateCreated: Date,
        workDays: [Int],
        hoursPerDay: Double,
        hourlyWage: Double,
        billing: Billing
    ) {
        self.appId = appId
        self.name = name
        self.dateCreated = dateCreated
        self.workDays = workDays
        self.hoursPerDay = hoursPerDay
        self.hourlyWage = hourlyWage
        self.billing = billing
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
        self.billing = Billing(days: model.billing)
    }
    
    public func model() async throws -> AccountModel {
        Model(
            appId: appId,
            name: name,
            dateCreated: dateCreated,
            workDays: workDays,
            hoursPerDay: hoursPerDay,
            hourlyWage: hourlyWage,
            billing: billing.days
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
            hourlyWage: 40.0,
            billing: .net45
        )
    }
    
    static func preview(id: String) -> Account {
        Account(
            appId: id,
            name: "Preview Account \(id)",
            dateCreated: .now,
            workDays: .defaultWorkDays,
            hoursPerDay: 8.0,
            hourlyWage: 40.0,
            billing: .net45
        )
    }
}

public extension Account {
    func isWorkDay(_ day: Date) -> Bool {
        workDays.contains(day.weekday())
    }
    
    func dueDate(from month: Date) -> Date {
        month.lastOfMonth().add(days: billing.days)
    }
}

fileprivate extension [Int] {
    static var defaultWorkDays: [Int] {
        [2, 3, 4, 5, 6]
    }
}
