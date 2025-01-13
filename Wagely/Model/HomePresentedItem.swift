//
//  HomePresentedItem.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI

public enum HomePresentedSheetItem: String {
    case congrats
}

extension HomePresentedSheetItem: Identifiable {
    public var id: String { rawValue }
}
