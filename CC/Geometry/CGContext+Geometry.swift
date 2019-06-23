//
//  CGContext+Geometry.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGContext {
  func addLine(_ line: Line) {
    self.addLines(between: [line.a, line.b])
  }
}
