//
//  Account.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation
import SwiftData

@Model
public final class AccountModel_V1 {
    var appId: String
    var name: String
    var dateCreated: Date
    var workDays: [Int]
    var hoursPerDay: Double
    var hourlyWage: Double
    
    init(
        appId: String,
        name: String,
        dateCreated: Date,
        workDays: [Int],
        hoursPerDay: Double,
        hourlyWage: Double
    ) {
        self.appId = appId
        self.name = name
        self.dateCreated = dateCreated
        self.workDays = workDays
        self.hoursPerDay = hoursPerDay
        self.hourlyWage = hourlyWage
    }
}

public typealias AccountModel = AccountModel_V1
