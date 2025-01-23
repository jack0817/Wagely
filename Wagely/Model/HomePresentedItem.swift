//
//  HomePresentedItem.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public enum HomePresentedSheetItem {
    case addException(day: Date)
}

extension HomePresentedSheetItem: Identifiable {
    public var id: String {
        switch self {
        case .addException: "Add Exception"
        }
    }
}
