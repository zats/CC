//
//  Drawable.swift
//  CC
//
//  Created by Sash Zats on 7/6/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public protocol Drawable {
  func draw(in context: CGContext)

  func transformed(_ t: CGAffineTransform) -> Self
}

public extension Drawable {
  func translatedBy(x: CGFloat, y: CGFloat) -> Self {
    return transformed(CGAffineTransform(translationX: x, y: y))
  }

  func translated(by point: CGPoint) -> Self {
    return transformed(CGAffineTransform(translationX: point.x, y: point.y))
  }

  func translated(by vector: CGVector) -> Self {
    return transformed(CGAffineTransform(translationX: vector.dx, y: vector.dy))
  }

  func scaled(by scale: CGFloat, around: CGPoint = .zero) -> Self {
    return transformed(CGAffineTransform
      .identity
      .translated(by: around)
      .scaledBy(x: scale, y: scale)
      .translated(by: -around))
  }

  func rotated(by angle: CGFloat, around: CGPoint) -> Self {
    return transformed(CGAffineTransform
      .identity
      .translated(by: around)
      .rotated(by: angle)
      .translated(by: -around))
  }

  func transformed(from: Line, to: Line) -> Self {
    let delta = to.a - from.a
    let angle = to.angle(between: from)
    let scale = to.length / from.length
    let around: CGPoint
    if let intersection = InfiniteLine(line: from).intersection(with: InfiniteLine(line: to)) {
      around = intersection
    } else {
      around = CGPoint.zero
    }
    let t = CGAffineTransform
      .identity
      .translated(by: from.a)
      .translated(by: delta)
      .rotated(by: angle)
      .scaledBy(x: scale, y: scale)
      .translated(by: -from.a)

    return transformed(t)
  }
}

extension Triangle: Drawable {
  public func draw(in context: CGContext) {
    context.addLines(between: [a, b, c, a])
  }

  public func transformed(_ t: CGAffineTransform) -> Triangle {
    return Triangle(a: a.applying(t),
                    b: b.applying(t),
                    c: c.applying(t))
  }
}
