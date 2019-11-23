//
//  PathHelpers.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public extension CGPath {
  static func polygon(center: CGPoint = .zero,
                      radius: CGFloat,
                      numberOfSides: Int,
                      orientation: CGFloat = 0) -> CGPath
  {
    guard numberOfSides >= 3 else {
      fatalError("numberOfSides must be greater than 3")
    }
    let points = (0..<numberOfSides).map { i in
      CGPoint(angle: CGFloat(i) / CGFloat(numberOfSides) * .pi * 2 + orientation,
              distance: radius,
              from: center)
    }
    let path = CGMutablePath()
    path.addLines(between: points)
    path.closeSubpath()
    return path
  }
}
