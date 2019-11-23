//
//  CGAffineTransformExtensions.swift
//  CC
//
//  Created by Sash Zats on 6/30/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public extension CGAffineTransform {
  func translated(by point: CGPoint) -> CGAffineTransform {
    return translatedBy(x: point.x, y: point.y)
  }

  func translated(by vector: CGVector) -> CGAffineTransform {
    return translatedBy(x: vector.dx, y: vector.dy)
  }
}
