//
//  DateExtensions.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation

public extension Date {
    func weekday(in cal: Calendar = .current) -> Int {
        cal.component(.weekday, from: self)
    }
    
    func firstOfMonth(in cal: Calendar = .current) -> Date {
        var comps = cal.dateComponents([.year, .month], from: self)
        comps.day = 1
        return cal.date(from: comps) ?? self
    }
    
    func lastOfMonth(in cal: Calendar = .current) -> Date {
        var comps = cal.dateComponents([.year, .month], from: self)
        comps.day = self.daysInMonthRange().upperBound
        return cal.date(from: comps) ?? self
    }
    
    func day(of day: Int, in cal: Calendar = .current) -> Date {
        var comps = cal.dateComponents([.year, .month], from: self)
        comps.day = day
        return cal.date(from: comps) ?? self
    }
    
    func daysInMonthRange(in cal: Calendar = .current) -> Range<Int> {
        cal.range(of: .day, in: .month, for: self) ?? 0 ..< 1
    }
    
    func daysInMonth(in cal: Calendar = .current) -> Int {
        cal.range(of: .day, in: .month, for: self)?.upperBound ?? 0
    }
    
    func add(days: Int, in cal: Calendar = .current) -> Date {
        cal.date(byAdding: .day, value: days, to: self) ?? self
    }
    
    func add(weekOfMonth: Int, in cal: Calendar = .current) -> Date {
        cal.date(byAdding: .weekOfMonth, value: weekOfMonth, to: self) ?? self
    }
    
    func add(months: Int, in cal: Calendar = .current) -> Date {
        cal.date(byAdding: .month, value: months, to: self) ?? self
    }
    
    func weekOfMonthRange(in cal: Calendar = .current) -> Range<Int> {
        cal.range(of: .weekOfMonth, in: .month, for: self) ?? 0 ..< 1
    }
    
    func weekdayRangeOfWeek(_ week: Int, in cal: Calendar = .current) -> Range<Int> {
        cal.range(of: .weekday, in: .weekOfMonth, for: self) ?? 0 ..< 1
    }
    
    func day(at weekdayOrdinal: Int, week: Int, in cal: Calendar = .current) -> Date? {
        var comps = cal.dateComponents([.year, .month], from: self)
        comps.weekday = weekdayOrdinal
        comps.weekOfMonth = week
        return cal.date(from: comps)
    }
}
