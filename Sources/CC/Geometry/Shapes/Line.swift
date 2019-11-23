//
//  Line.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics
import CoreGraphics


public struct InfiniteLine {
  public enum Definition {
    case sloped(slope: CGFloat, yIntercept: CGFloat)
    case vertical(x: CGFloat)
  }

  var definition: Definition

  public init(xInterscept: CGFloat) {
    self.definition = .vertical(x: xInterscept)
  }

  public init(slope: CGFloat, yInterscept: CGFloat) {
    self.definition = .sloped(slope: slope, yIntercept: yInterscept)
  }

  public init(a: CGPoint, b: CGPoint) {
    let dx = a.x - b.x
    if dx == 0.0 {
      self.init(xInterscept: a.x)
    } else {
      let slope = (a.y - b.y) / dx
      self.init(slope: slope, yInterscept: (slope * -a.x) + a.y)
    }
  }

  public init(a: CGPoint, angle: CGFloat) {
    let unitPoint = CGPoint(angle: angle, distance: 1, from: a)
    self.init(a: a, b: unitPoint)
  }

  public init(line: Line) {
    self.init(a: line.a, b: line.b)
  }

  public func point(atX x: CGFloat) -> CGPoint? {
    guard case let .sloped(slope, yIntercept) = definition else { return nil }
    return CGPoint(x: x, y: slope * x + yIntercept)
  }

  public func intersection(with line: InfiniteLine) -> CGPoint? {
    switch (self.definition, line.definition) {
    case let (.sloped(slope1, yIntercept1),
              .sloped(slope2, yIntercept2)):
      let dSlope = slope1 - slope2
      guard dSlope != 0.0 else { return nil } // parallel
      return point(atX: (yIntercept2 - yIntercept1) / dSlope)
    case let (.vertical(x), .sloped(slope, yIntercept)),
         let (.sloped(slope, yIntercept), .vertical(x)):
      return CGPoint(x: x, y: slope * x + yIntercept)
    default: return nil
    }
  }

  private static func pointHashCalculator(point: CGPoint, hasher: inout Hasher) {
    hasher.combine(Int(point.x))
    hasher.combine(Int(point.y))
  }

  private static func pointEqualityCalculator(p1: CGPoint, p2: CGPoint) -> Bool {
    return Int(p1.x) == Int(p2.x) && Int(p1.y) == Int(p2.y)
  }

  public func clipped(to bounds: CGRect) -> Line? {
    var points: Set<CustomHashable<CGPoint>> = []
    for edge in Polygon(rect: bounds).edges {
      if let intersection = self.intersection(with: InfiniteLine(line: edge)) {
        points.insert(CustomHashable(value: intersection,
                                     hashCalculator: InfiniteLine.pointHashCalculator,
                                     equalityCalculator: InfiniteLine.pointEqualityCalculator))
      }
    }
    if points.count >= 2 {
      let pointsArr = Array(points)
      return Line(a: pointsArr[0].value, b: pointsArr[1].value)
    } else {
      return nil
    }
  }
}

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

}

public extension Line {
  func point(at t: CGFloat) -> CGPoint {
    return a.interpolated(to: b, t: t)
  }
}

extension Line: Equatable {
  public static func ==(lhs: Line, rhs: Line) -> Bool {
    return lhs.a == rhs.a && lhs.b == rhs.b
  }
}

public extension Line {
  var length: CGFloat {
    return self.a.distance(to: self.b)
  }

  var angle: CGFloat {
    return self.b.polarAngle(reference: self.a)
  }

  func angle(between line: Line) -> CGFloat {
    return b.polarAngle(reference: a) - line.b.polarAngle(reference: line.a)
  }

  var midPoint: CGPoint {
    return a + (b - a) * 0.5
  }

  func reversed() -> Line {
    return Line(a: b, b: a)
  }

  var delta: CGPoint {
    return b - a
  }

}

extension Line: Drawable {
  public func draw(in context: CGContext) {
    context.addLine(self)
  }

  public func transformed(_ t: CGAffineTransform) -> Line {
    return Line(a: a.applying(t), b: b.applying(t))
  }
}
