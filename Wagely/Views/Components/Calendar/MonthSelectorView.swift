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
    let dayState: (Date) -> MonthView.DayState
    let action: (DayAction) -> Void
    
    @Environment(\.calendar) private var calendar
    @Environment(\.theme) private var theme
    @State private var showDatePicker = false
    
    public init(
        selectedMonth: Binding<Date>,
        in size: CGSize,
        dayState: @escaping (Date) -> MonthView.DayState,
        action: @escaping  (DayAction) -> Void
    ) {
        self._selectedMonth = selectedMonth
        self.size = size
        self.dayState = dayState
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            headerView()
                .padding(.horizontal, 16.0)
                .padding(.bottom, 16.0)
            
            weekdayView(in: size)
            
            MonthView(
                month: selectedMonth.firstOfMonth(),
                size: size,
                dayState: dayState,
                action: action
            )
        }
        .sheet(isPresented: $showDatePicker) {
            DatePickerSheetView(selection: $selectedMonth)
                .presentationDetents([.medium])
        }
    }
    
    func headerView() -> some View {
        VStack {
            ZStack {
                HStack {
                    Button("Back") {
                        selectedMonth = selectedMonth.firstOfMonth().add(months: -1)
                    }
                    
                    Spacer()
                    
                    Button("Home") {
                        selectedMonth = Date.now.firstOfMonth()
                    }
                    
                    Button("Next") {
                        selectedMonth = selectedMonth.firstOfMonth().add(months: 1)
                    }
                }
                
                Button(
                    action: { showDatePicker.toggle() },
                    label: {
                        Text(selectedMonth.firstOfMonth(), format: .dateTime.month(.wide))
                            .font(.title)
                            .contentShape(Rectangle())
                    }
                )
                .frame(maxWidth: .infinity)
            }
            
            Text(selectedMonth, format: .dateTime.year())
                .font(.caption)
                .frame(maxWidth: .infinity)
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
                MonthSelectorView(
                    selectedMonth: $month,
                    in: geo.size,
                    dayState: { _ in .workDay },
                    action: { _ in  }
                )
                .frame(height: geo.size.height * 0.5)
            }
        }
    }
    
    return Preview()
}
