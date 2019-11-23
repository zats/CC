//
//  Circle.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Circle {
  public let center: CGPoint
  public let radius: CGFloat

  public init(center: CGPoint, radius: CGFloat) {
    self.center = center
    self.radius = radius
  }

  public init(rect: CGRect) {
    self.init(center: rect.center, radius: rect.precscribedCircleRadius)
  }
}

public extension Circle {
  func maximumNumberOfCircles(radius: CGFloat) -> Int {
    let angle = 2 * asin(radius * 2 / (2 * self.radius))
    return Int(CGFloat.pi * 2 / angle)
  }

  func maximumRadiusOfCircles(n: Int) -> CGFloat {
    let angle = CGFloat.pi * 2 / CGFloat(n)
    let radius = self.radius * sin(0.5 * angle)
    // TODO: this is not actually accurate, this returns a hord
    return radius
  }

  func angle(for length: CGFloat) -> CGFloat {
    return length / self.radius
  }

  func length(for angle: CGFloat) -> CGFloat {
    return radius * angle
  }

  func point(at angle: CGFloat) -> CGPoint {
    return CGPoint(angle: angle, distance: radius, from: center)
  }
}
