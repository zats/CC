//
//  Polygon.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public struct Polygon {
  public var vertices: [CGPoint]

  public init(vertices: [CGPoint]) {
    self.vertices = vertices
  }
}

public extension Polygon {
  init(numberOfVertices: Int, radius: CGFloat, center: CGPoint, orientation: CGFloat) {
    self.init(vertices: stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi * 2 / CGFloat(numberOfVertices)).map {
      CGPoint(angle: $0 + orientation, distance: radius, from: center)
    })
  }
}

public extension Polygon {
  /**
   Converts `CGRect` to `Polygon` in the counterclockwise order:
    1. top-left
    2. bottom-left
    3. bottom-right
    4. top-right
   */
  init(rect: CGRect) {
    self.vertices = [
      CGPoint(x: rect.minX, y: rect.minY),
      CGPoint(x: rect.minX, y: rect.maxY),
      CGPoint(x: rect.maxX, y: rect.maxY),
      CGPoint(x: rect.maxX, y: rect.minY),
    ]
  }

  var cgPath: CGPath {
    let path = CGMutablePath()
    path.addLines(between: self.vertices)
    path.closeSubpath()
    return path
  }
}
