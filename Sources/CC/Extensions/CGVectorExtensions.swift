//
//  CGVectorExtensions.swift
//  CC
//
//  Created by Sash Zats on 4/16/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public extension CGVector {
  static func +(lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
  }

  static func +=(lhs: inout  CGVector, rhs: CGVector) {
    lhs.dx += rhs.dx
    lhs.dy += rhs.dy
  }

  static prefix func -(lhs: CGVector) -> CGVector {
    return CGVector(dx: -lhs.dx, dy: -lhs.dy)
  }

  static func -(lhs: CGVector, rhs: CGVector) -> CGVector {
    return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy)
  }

  static func *(lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx * rhs, dy: lhs.dy * rhs)
  }

  static func *(lhs: CGFloat, rhs: CGVector) -> CGVector {
    return CGVector(dx: rhs.dx * lhs, dy: rhs.dy * lhs)
  }

  static func /(lhs: CGVector, rhs: CGFloat) -> CGVector {
    return CGVector(dx: lhs.dx / rhs, dy: lhs.dy / rhs)
  }

  /// - returns: A `CGPoint` with x: dx and y: dy.
  var point: CGPoint {
    return CGPoint(x: dx, y: dy)
  }

  var magnitude: CGFloat {
    return sqrt(dx * dx + dy * dy)
  }
  var angle: CGFloat {
    return atan2(dy, dx)
  }

  init(angle: CGFloat, magnitude: CGFloat, from origin: CGVector = .zero) {
    self.init(dx: magnitude * cos(angle) + origin.dx,
              dy: magnitude * sin(angle) + origin.dy)
  }

  var inversed: CGVector {
    return CGVector(dx: -dx, dy: -dy)
  }
}


public extension CGVector {
  static func random(angle: ClosedRange<CGFloat> = 0...CGFloat.pi * 2, magnitude: ClosedRange<CGFloat>, from origin: CGVector = .zero) -> CGVector {
    return CGVector(angle: CGFloat.random(in: angle), magnitude: CGFloat.random(in: magnitude), from: origin)
  }

  @inlinable static func random(inX xRange: Range<CGFloat>, y yRange: Range<CGFloat>) -> CGVector {
    return CGVector(dx: CGFloat.random(in: xRange), dy: CGFloat.random(in: yRange))
  }

  @inlinable static func random(inX xRange: ClosedRange<CGFloat>, y yRange: ClosedRange<CGFloat>) -> CGVector {
    return CGVector(dx: CGFloat.random(in: xRange), dy: CGFloat.random(in: yRange))
  }
}

public extension CGVector {
  var cgPoint: CGPoint {
    return CGPoint(x: dx, y: dy)
  }
}
