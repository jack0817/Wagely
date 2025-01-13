//
//  MonthView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct MonthView: View {
    let month: Date
    let size: CGSize
    
    @Environment(\.calendar) private var calendar
    @Environment(\.theme) private var theme
    
    var body: some View {
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
                                Text(day, format: .dateTime.day())
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
    
    func dayDimension(in size: CGSize) -> CGFloat {
        guard size.width > 0 && weekdayCount > 0 else { return 0.0 }
        return size.width / CGFloat(weekdayCount)
    }
}

#Preview {
    GeometryReader { geo in
        MonthView(
            month: Date.now.firstOfMonth(),
            size: geo.size
        )
    }
}
