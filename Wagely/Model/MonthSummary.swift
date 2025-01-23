//
//  MonthSummary.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import Foundation

public struct MonthSummary: Equatable {
    let month: Date
    let workDays: Int
    let hours: Double
    let wages: Double
}

public extension MonthSummary {
    static func empty(_ month: Date) -> MonthSummary {
        .init(
            month: month,
            workDays: 0,
            hours: 0,
            wages: 0
        )
    }
}

public extension MonthSummary {
    static func += (lhs: inout MonthSummary, rhs: MonthSummary) {
        guard lhs.month == rhs.month else { return }
        lhs = .init(
            month: lhs.month,
            workDays: lhs.workDays + rhs.workDays,
            hours: lhs.hours + rhs.hours,
            wages: lhs.wages + rhs.wages
        )
    }
}
