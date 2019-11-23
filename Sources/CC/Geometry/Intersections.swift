//
//   Intersections.swift
//   CC
//
//   Created by Sash Zats on 6 / 22 / 19.
//   Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public enum CircleLineIntersection {
  case one(CGPoint)
  case two(CGPoint, CGPoint)
}

public enum LineRectIntersection: Equatable {
  case none
  case one(CGPoint)
  case two(CGPoint, CGPoint)

  public static func ==(lhs: LineRectIntersection, rhs: LineRectIntersection) -> Bool {
    switch (lhs, rhs) {
    case (.none, .none):
      return true
    case let (.one(p1), .one(p2)):
      return p1 == p2
    case let (.two(p11, p12), .two(p21, p22)):
      return (p11 == p21 && p12 == p22) || (p11 == p22 && p12 == p21)
    default:
      return false
    }
  }
}

public extension Circle {
  func intersection(with line: Line) -> CircleLineIntersection? {
    return line.intersection(with: self)
  }
}

public extension InfiniteLine {

}

public extension Line {
  // Copied from "GeomUtils 4.as"
  // yeap "as" stands for "ActionSctipt"
  func intersection(with circle: Circle) -> CircleLineIntersection? {
    let p1 = self.a
    let p2 = self.b
    let p3 = circle.center
    let r = circle.radius
    let d = p2 - p1

    let a = d.lengthSquared
    let b = 2 * (d.x * (p1.x - p3.x) + d.y * (p1.y - p3.y))
    let c = p3.x * p3.x + p3.y * p3.y + p1.x * p1.x + p1.y * p1.y - 2 * (p3.x * p1.x + p3.y * p1.y) - r * r
    var bb4ac = b * b - 4*a*c
    if (bb4ac < 0) {
      return nil
    }
    bb4ac = sqrt(bb4ac)

    var u0: CGFloat
    if (bb4ac > 0) {
      u0 = 0.5*(-b + bb4ac)/a
      let u1 = 0.5*(-b - bb4ac)/a
      return .two(CGPoint(x: p1.x + u0*d.x, y: p1.y + u0*d.y),
                  CGPoint(x: p1.x + u1*d.x, y: p1.y + u1*d.y))
    } else {
      u0 = -0.5*b/a
      return .one(CGPoint(x: p1.x + u0*d.x,
                          y: p1.y + u0*d.y))
    }
  }

  func intersection(with line: Line) -> CGPoint? {
    let d1 = self.b - self.a
    let d2 = line.b - line.a
    let d = d2.y * d1.x - d2.x * d1.y
    if abs(d) < CGFloat.ulpOfOne {
      return nil
    }
    let dAA = self.a - line.a
    let u0 = (d2.x * dAA.y - d2.y * dAA.x) / d
    let u1 = (d1.x * dAA.y - d1.y * dAA.x) / d
    if u0 < 0 || u0 > 1 || u1 < 0 || u1 > 1 {
      return nil
    }
    return CGPoint(x: a.x + u0 * d1.x,
                   y: a.y + u0 * d1.y);
  }

  func intersection(with rect: CGRect) -> LineRectIntersection {
    let edges = Polygon(rect: rect).edges
    let results = edges.compactMap {
      self.intersection(with: $0)
    }
    if results.count == 0 {
      return .none
    } else if results.count == 1 {
      return .one(results[0])
    } else {
      return .two(results[0], results[1])
    }
  }
}
