//
//  Log.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/15/25.
//

import Foundation

// MARK: Log

public struct Log: CustomDebugStringConvertible {
    fileprivate static var level: Level = .debug
    
    let level: Log.Level
    let date: Date
    let message: String
    
    public var debugDescription: String {
        [
            Self.dateFormatter.string(from: date),
            level.tag,
            message
        ]
        .joined(separator: " - ")
    }
}

public extension Log {
    enum Level: Int {
        case error = 0
        case debug = 1
        case warning = 2
        case info = 3
        
        var tag: String {
            switch self {
            case .error: return "[ERROR]"
            case .warning: return "[WARNING]"
            case .debug: return "[DEBUG]"
            case .info: return "[INFO]"
            }
        }
    }
}

// MARK: Static API

public extension Log {
    static func setLevel(to level: Level) {
        Self.level = level
    }

    static func error(_ error: Error) {
        Self.error("\(error)")
    }
    
    static func error(_ message: String) {
        Self.logMessage(.error, message: message)
    }
    
    static func debug(_ message: String) {
        Self.logMessage(.debug, message: message)
    }
    
    static func warning(_ message: String) {
        Self.logMessage(.warning, message: message)
    }
    
    static func info(_ message: String) {
        Self.logMessage(.info, message: message)
    }
}

// MARK: Private Static API

public extension Log {
    static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss:SSSS"
        return formatter
    }()
    
    static func logMessage(_ level: Log.Level, message: String) {
        guard level.rawValue <= Log.level.rawValue else { return }
        let log = Log(level: level, date: .now, message: message)
        print(log.debugDescription)
    }
}
