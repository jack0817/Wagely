//
//  SummaryService.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import Foundation
import AsyncStore

public struct SummaryService {
    fileprivate static let shared = SummaryService()
    
    private init() {}
    
    public func summary(for month: Date, accounts: [Account]) async -> MonthSummary {
        let start = month.firstOfMonth()
        
        return accounts
            .map { account -> MonthSummary in
                start.daysInMonthRange()
                    .map { dayOffset -> MonthSummary in
                        let day = month.day(of: dayOffset)
                        guard account.isWorkDay(day) else { return MonthSummary.empty(month) }
                        
                        return .init(
                            month: month,
                            workDays: 1,
                            hours: account.hoursPerDay,
                            wages: account.hourlyWage * account.hoursPerDay
                        )
                    }
                    .reduce(into: MonthSummary.empty(month)) { monthSummary, summary in
                        monthSummary += summary
                    }
            }
            .reduce(into: MonthSummary.empty(month)) { totalSummary, summary in
                totalSummary += summary
            }
    }
}

// MARK: AsyncStore Environment

enum SummaryServiceEnvironmentKey: AsyncStoreEnvironmentKey {
    static var defaultValue: SummaryService { .shared }
}

public extension AsyncStoreEnvironmentValues {
    var summaryService: SummaryService {
        get { self[SummaryServiceEnvironmentKey.self] }
    }
}
