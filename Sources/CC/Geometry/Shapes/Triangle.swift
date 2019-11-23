//
//  Triangle.swift
//  CC
//
//  Created by Sash Zats on 7/6/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public struct Triangle {
  public var a: CGPoint, b: CGPoint, c: CGPoint
  public init(a: CGPoint, b: CGPoint, c: CGPoint) {
    self.a = a
    self.b = b
    self.c = c
  }

  public init(a: CGPoint, db: CGVector, dc: CGVector) {
    self.a = a
    let b = a + db
    self.b = b
    self.c = b + dc
  }

  public init(vertices: [CGPoint]) {
    self.init(a: vertices[0],
              b: vertices[1],
              c: vertices[2])
  }

}

public extension Triangle {
  static func equilateral(origin: CGPoint, radius: CGFloat, angle offset: CGFloat = 0) -> Triangle {
    var vertices: [CGPoint] = []
    for angle: CGFloat in stride(from: 0, through: CGFloat.pi * 2, by: CGFloat.pi * 2 / 3) {
      vertices.append(CGPoint(angle: angle + offset, distance: radius, from: origin))
    }
    return Triangle(vertices: vertices)
  }
}

public extension Triangle {
  var ab: Line {
    return Line(a: a, b: b)
  }
  var bc: Line {
    return Line(a: b, b: c)
  }
  var ca: Line {
    return Line(a: c, b: a)
  }
  var sides: [Line] {
    return [
      ab,
      bc,
      ca,
    ]
  }

  var centroid: CGPoint {
    return (a + b + c) / 3
  }
}

public extension CGContext {
  func addTriangle(_ triangle: Triangle) {
    self.addLines(between: triangle.vertices + [triangle.a])
  }
}
