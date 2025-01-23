//
//  MonthView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public struct MonthView: View {
    let month: Date
    let size: CGSize
    let dayState: (Date) -> DayState
    let action: (DayAction) -> Void
    
    @Environment(\.calendar) private var calendar
    @Environment(\.theme) private var theme
    
    public var body: some View {
        Grid(
            alignment: .center,
            horizontalSpacing: 0.0,
            verticalSpacing: 0.0
        ) {
            ForEach(month.weekOfMonthRange(in: calendar), id: \.self) { week in
                GridRow(alignment: .center) {
                    ForEach(month.weekdayRangeOfWeek(week), id: \.self) { weekday in
                        Group {
                            if
                                let day = month.day(at: weekday, week: week),
                                calendar.isDate(day, equalTo: month, toGranularity: .month)
                            {
                                dayView(for: day, dayState: dayState(day))
                            } else {
                                Color.clear
                            }
                        }
                        .frame(
                            width: dayDimension(in: size),
                            height: dayDimension(in: size)
                        )
                    }
                }
            }
        }
    }
    
    var weekdayCount: Int {
        calendar.weekdaySymbols.count
    }
    
    func dayView(for day: Date, dayState: DayState) -> some View {
        ZStack {
            view(for: dayState)
            Text(day, format: .dateTime.day())
                .foregroundStyle(dayState.foregroundColor(in: theme))
        }
        .contentShape(Circle())
        .contentShape(.contextMenuPreview, Circle())
        .contextMenu {
            Section(contextMenuTitle(for: day)) {
                Button(action: { action(.addException(day: day)) }) {
                    Label("Add Exception", systemImage: "pencil")
                }
            }
        }
        .padding(4.0)
    }
    
    @ViewBuilder func view(for dayState: DayState) -> some View {
        switch dayState {
        case .none:
            Circle()
                .stroke(.clear, lineWidth: 2.0)
                .padding(1.0)
        case .workDay:
            Circle()
                .stroke(.blue, lineWidth: 2.0)
                .padding(1.0)
        }
    }
    
    func dayDimension(in size: CGSize) -> CGFloat {
        guard size.width > 0 && weekdayCount > 0 else { return 0.0 }
        return size.width / CGFloat(weekdayCount)
    }
    
    func contextMenuTitle(for day: Date) -> String {
        DateFormatterUtility.formatter(for: .dayMonthYear).string(from: day)
    }
}

public extension MonthView {
    enum DayState {
        case none
        case workDay
        
        func foregroundColor(in theme: Theme) -> Color {
            switch self {
            case .none:
                theme.color(.backgroundInverse)
            case .workDay:
                theme.color(.backgroundInverse)
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        MonthView(
            month: Date.now.firstOfMonth(),
            size: geo.size,
            dayState: { Calendar.current.isDateInWeekend($0) ? .none : .workDay },
            action: { _ in  }
        )
    }
}
