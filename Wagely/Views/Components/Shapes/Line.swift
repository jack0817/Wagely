//
//  Line.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/16/25.
//

import SwiftUI

public struct Line: Shape {
    public nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .init(x: rect.minX, y: rect.height * 0.5))
            path.addLine(to: .init(x: rect.maxX, y: rect.height * 0.5))
            path.closeSubpath()
        }
    }
}
