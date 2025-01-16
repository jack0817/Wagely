//
//  Billing.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import Foundation

public enum Billing: Equatable {
    case net7
    case net10
    case net30
    case net45
    case net60
    case net90
    case custom(days: Int)
    
    var days: Int {
        switch self {
        case .net7: 7
        case .net10: 10
        case .net30: 30
        case .net45: 45
        case .net60: 60
        case .net90: 90
        case .custom(let days): days
        }
    }
    
    init(days: Int) {
        switch days {
        case 7: self = .net7
        case 10: self = .net10
        case 30: self = .net30
        case 45: self = .net45
        case 60: self = .net60
        case 90: self = .net90
        default: self = .custom(days: days)
        }
    }
}
