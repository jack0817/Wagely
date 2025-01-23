//
//  SummaryTotalsView.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

struct SummaryTotalsView: View {
    enum SummarySection: CaseIterable, Identifiable {
        case wages
        case hours
        case days
        
        var title: String {
            switch self {
            case .wages: "Wages"
            case .hours: "Hours"
            case .days: "Days"
            }
        }
        
        var localizedTitle: LocalizedStringKey {
            .init(title)
        }
        
        var systemImage: String {
            switch self {
            case .wages: "dollarsign"
            case .hours: "clock"
            case .days: "calendar"
            }
        }
        
        var id: String { title }
    }
    
    let summary: MonthSummary
    @Binding var isCollapsed: Bool
    
    @Environment(\.theme) private var theme
    @Namespace private var namespace
    
    private var currencyCode: String  {
        Locale.current.currency?.identifier ?? "USD"
    }
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Text("Totals")
                    .font(theme.font(.heading3).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(
                    action: { isCollapsed.toggle() },
                    label: {
                        Image(systemName: "chevron.up")
                            .rotation3DEffect(.degrees(isCollapsed ? 180.0 : 0.0), axis: (1.0, 0.0, 0.0))
                    }
                )
            }
            
            if isCollapsed {
                HStack { sections() }
            } else {
                VStack { sections() }
            }
        }
        .animation(.easeOut, value: isCollapsed)
    }
    
    func sections() -> some View {
        Group {
            ForEach(SummarySection.allCases) { section in
                if isCollapsed {
                    VStack {
                        Image(systemName: section.systemImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16.0, height: 16.0)
                        
                        textView(for: section)
                            .matchedGeometryEffect(id: section.title, in: namespace)
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    HStack {
                        Text(section.localizedTitle)
                        
                        Line()
                            .stroke(theme.color(.backgroundInverse))
                            .frame(height: 1.0)
                        
                        textView(for: section)
                            .matchedGeometryEffect(id: section.title, in: namespace)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func textView(for section: SummaryTotalsView.SummarySection) -> some View {
        switch section {
        case .wages:
            Text(summary.wages, format: .currency(code: currencyCode))
                .textSelection(.enabled)
        case .hours:
            Text(summary.hours, format: .number.precision(.fractionLength(1)))
        case .days:
            Text(summary.workDays, format: .number)
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

fileprivate extension SummaryTotalsView {
    var lineDash: [CGFloat] {
        [4.0, 4.0]
    }
}

#Preview {
    struct Preview: View {
        @State private var isCollapsed = false
        
        var body: some View {
            SummaryTotalsView(
                summary: .init(
                    month: .now.firstOfMonth(),
                    workDays: 20,
                    hours: 180.0,
                    wages: 1000.0
                ),
                isCollapsed: $isCollapsed
            )
            .padding()
        }
    }
    
    return Preview()
        .environment(\.locale, .init(identifier: "es_ES"))
}
