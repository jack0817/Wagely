//
//  Runtime.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/20/25.
//

import Foundation

public enum Runtime {
    public static var isPreviews: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
