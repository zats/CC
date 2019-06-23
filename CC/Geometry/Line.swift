//
//  Line.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public struct Line {
  public var a: CGPoint
  public var b: CGPoint

  public init(a: CGPoint, b: CGPoint) {
    self.a = a
    self.b = b
  }

  public init(center: CGPoint, direction: CGFloat, length: CGFloat) {
    self.init(
      a: CGPoint(angle: direction - .pi / 2, distance: length * 0.5, from: center),
      b: CGPoint(angle: direction + .pi / 2, distance: length * 0.5, from: center)
    )
  }

  public var length: CGFloat {
    return self.a.distance(to: self.b)
  }
}
