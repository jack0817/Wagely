//
//  HomeNavigationItem.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation

public enum HomeNavigationItem: String {
    case details
}

extension HomeNavigationItem: Identifiable {
    public var id: String { rawValue }
}
