//
//  Account.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import Foundation
import SwiftData

@Model
public final class Account_V1 {
    var name: String
    var dateCreated: Date
    
    init(name: String, dateCreated: Date) {
        self.name = name
        self.dateCreated = dateCreated
    }
}

public typealias Account = Account_V1
