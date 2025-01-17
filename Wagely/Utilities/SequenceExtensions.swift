//
//  SequenceExtensions.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/17/25.
//

import Foundation

public extension Array where Element: Comparable {
    func sorted(_ direction: (Element, Element) -> Bool) -> Self {
        sorted(by: \.self, direction)
    }
}

public extension Array {
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>, _ direction: (Value, Value) -> Bool) -> Self {
        sorted { direction($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
}
