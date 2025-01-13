//
//  MonthSelectorView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

struct MonthSelectorView: View {
    @Binding private var selectedMonth: Date
    let size: CGSize
    
    @Environment(\.calendar) private var calendar
    @Environment(\.theme) private var theme
    
    public init(selectedMonth: Binding<Date>, in size: CGSize) {
        self._selectedMonth = selectedMonth
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            headerView()
                .padding(.horizontal, 16.0)
                .padding(.bottom, 16.0)
            
            weekdayView(in: size)
            MonthView(month: selectedMonth.firstOfMonth(), size: size)
        }
    }
    
    func headerView() -> some View {
        HStack {
            Button("Back") {
                selectedMonth = selectedMonth.firstOfMonth().add(months: -1)
            }
            
            Text(selectedMonth.firstOfMonth(), format: .dateTime.month(.wide))
                .font(.title)
                .frame(maxWidth: .infinity)
            
            Button("Next") {
                selectedMonth = selectedMonth.firstOfMonth().add(months: 1)
            }
        }
    }
    
    var weekdayCount: Int {
        calendar.weekdaySymbols.count
    }
    
    func weekdayView(in size: CGSize) -> some View {
        HStack(spacing: 0.0) {
            ForEach(0 ..< weekdayCount, id: \.self) { weekday in
                Text(calendar.veryShortWeekdaySymbols[weekday])
                    .frame(width: dayDimension(in: size))
            }
        }
    }
    
    func dayDimension(in size: CGSize) -> CGFloat {
        guard size.width > 0 && weekdayCount > 0 else { return 0.0 }
        return size.width / CGFloat(weekdayCount)
    }
}

#Preview {
    struct Preview: View {
        @State private var month = Date.now
        
        var body: some View  {
            GeometryReader { geo in
                MonthSelectorView(selectedMonth: $month, in: geo.size)
                    .frame(height: geo.size.height * 0.5)
            }
        }
    }
    
    return Preview()
}