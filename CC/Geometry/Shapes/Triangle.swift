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
