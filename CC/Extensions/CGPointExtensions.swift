//
//  CGPointExtensions.swift
//  CC
//
//  Created by Sash Zats on 4/16/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public extension CGPoint {
  static prefix func -(lhs: CGPoint) -> CGPoint {
    return CGPoint(x: -lhs.x, y: -lhs.y)
  }

  static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
  }

  static func +=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs.x += rhs.x
    lhs.y += rhs.y
  }

  static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
  }

  static func *(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
    return lhs.dot(rhs)
  }

  static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
  }

  static func *(rhs: CGFloat, lhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
  }

  static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
  }

  func translated(by dx: CGFloat, _ dy: CGFloat) -> CGPoint {
    return CGPoint(x: x + dx, y: y + dy)
  }

  /// - returns: A `CGVector` with dx: x and dy: y.
  var vector: CGVector {
    return CGVector(dx: x, dy: y)
  }

  /// - returns: A `CGPoint` with rounded x and y values.
  var rounded: CGPoint {
    return CGPoint(x: round(x), y: round(y))
  }

  var length: CGFloat {
    return sqrt(x * x + y * y)
  }
  
  var lengthSquared: CGFloat {
    return x * x + y * y
  }

  /// - returns: The Euclidean distance from self to the given point.
  func distance(to point: CGPoint) -> CGFloat {
    return (point - self).vector.magnitude
  }

  /// - returns: The relative position inside the provided rect.
  func position(in rect: CGRect) -> CGPoint {
    return CGPoint(x: x - rect.origin.x,
                   y: y - rect.origin.y)
  }

  /// - returns: The position inside the provided rect,
  /// where horizontal and vertical position are normalized
  /// (i.e. mapped to 0-1 range).
  func normalizedPosition(in rect: CGRect) -> CGPoint {
    let p = position(in: rect)
    return CGPoint(x: (1.0 / rect.width) * p.x,
                   y: (1.0 / rect.width) * p.y)
  }

  /// Interpolates between `self` and `other` points by value `t`
  func interpolated(to other: CGPoint, t: CGFloat) -> CGPoint {
    return self + (other - self) * t
  }

  func interpolated(to other: CGPoint, by distance: CGFloat) -> CGPoint {
    return self.interpolated(to: other, t: distance / self.distance(to: other))
  }

  init(angle: CGFloat, distance: CGFloat, from point: CGPoint = .zero) {
    self.init(x: distance * cos(angle) + point.x,
              y: distance * sin(angle) + point.y)
  }

  /// - returns: The `Angle` between horizontal line through `self`,
  /// and line from `self` to `reference.
  func polarAngle(reference: CGPoint) -> CGFloat {
    return (self - reference).vector.angle
  }

  /// - returns: The `Angle` between line from `self` to `previous`
  /// and `self` to `next`, i.e. the angle at vertex `self`
  /// of triangle (`previous`,`self`,`next`).
  func angle(previous: CGPoint, next: CGPoint) -> CGFloat {
    let v1 = previous - self
    let v2 = next - self
    return atan2(v1.y, v1.x) - atan2(v2.y, v2.x)
  }

}

public extension CGPoint {
  static func random(angle: ClosedRange<CGFloat> = 0...CGFloat.pi * 2, magnitude: ClosedRange<CGFloat>, from origin: CGPoint = .zero) -> CGPoint {
    return CGPoint(angle: CGFloat.random(in: angle), distance: CGFloat.random(in: magnitude), from: origin)
  }
}

public extension CGPoint {
  init(index: Int, width: Int) {
    let y = index / width
    self.init(x: index - y * width, y: y)
  }
}

public extension CGPoint {
  func dot(_ other: CGPoint) -> CGFloat {
    return self.length * other.length * cos(other.polarAngle(reference: self))
  }
}
