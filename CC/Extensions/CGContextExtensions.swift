//
//  CGContextExtensions.swift
//  CC
//
//  Created by Sash Zats on 4/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public extension CGContext {
  func preserving(_ block: () -> Void) {
    saveGState()
    block()
    restoreGState()
  }

  func stroke(with stroke: XPlatColor, fill: XPlatColor) {
    if let path = self.path {
      strokePath(with: stroke)
      addPath(path)
      fillPath(with: fill)
    }
  }

  func fill(with fill: XPlatColor, stroke: XPlatColor) {
    if let path = self.path {
      fillPath(with: fill)
      addPath(path)
      strokePath(with: stroke)
    }
  }

  func strokePath(with color: XPlatColor) {
    preserving {
      color.setStroke()
      strokePath()
    }
  }

  func fillPath(with color: XPlatColor) {
    preserving {
      color.setFill()
      fillPath()
    }
  }
}
