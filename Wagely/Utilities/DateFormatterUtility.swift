//
//  DateFormatterUtility.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import Foundation
import SwiftUI

public final class DateFormatterUtility {
    private static var formatters: [Format: DateFormatter] = [:]
    
    static func formatter(for format: Format) -> DateFormatter {
        guard let formatter = formatters[format] else {
            let newFormatter = format.formatter
            Self.formatters[format] = newFormatter
            return newFormatter
        }
        
        return formatter
    }
}

public extension DateFormatterUtility {
    enum Format: Hashable {
        case dayMonthYear
        case monthOnly
    }
}

fileprivate extension DateFormatterUtility.Format {
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        
        switch self {
        case .dayMonthYear:
            formatter.dateFormat = "dd MMM yyyy"
        case .monthOnly:
            formatter.dateFormat = "MMMM"
        }
        
        return formatter
    }
}

public extension Text {
    init(date: Date, format: DateFormatterUtility.Format) {
        self = .init(DateFormatterUtility.formatter(for: format).string(from: date))
    }
}
