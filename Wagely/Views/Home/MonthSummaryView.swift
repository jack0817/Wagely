//
//  MonthSummaryView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct MonthSummaryView: View {
    enum SummarySection: String, CaseIterable, Identifiable {
        case wages = "Total Wages"
        case hours = "Total Hours"
        case days = "Total Days"
        
        var id: String { rawValue }
    }
    
    let summary: MonthSummary
    
    @Environment(\.theme) private var theme
    
    private var currencyCode: String  {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        VStack(spacing: 8.0) {
            Text("Summary")
                .font(theme.font(.heading3).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(SummarySection.allCases) { section in
                listTemplate(for: section.rawValue) {
                    switch section {
                    case .wages:
                        Text(summary.wages, format: .currency(code: currencyCode))
                            .textSelection(.enabled)
                    case .hours:
                        Text(summary.hours, format: .number.precision(.fractionLength(1)))
                    default:
                        Text(summary.workDays, format: .number)
                    }
                }
                .font(theme.font(.body))
            }
        }
    }
    
    func listTemplate<Content: View>(for title: String, @ViewBuilder value: () -> Content) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8.0) {
            Text(title)
            
            Line()
                .stroke(theme.color(.backgroundInverse))
                .frame(height: 1.0)
            
            value()
        }
    }
}

fileprivate extension MonthSummaryView {
    var lineDash: [CGFloat] {
        [4.0, 4.0]
    }
}

#Preview {
    MonthSummaryView(
        summary: .init(
            month: .now.firstOfMonth(),
            workDays: 20,
            hours: 180.0,
            wages: 1000.0
        )
    )
    .padding()
}
