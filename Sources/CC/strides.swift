//
//  strides.swift
//  CC
//
//  Created by Sash Zats on 4/17/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public func stride(_ rect: CGRect, step: (Int, Int)) -> [CGPoint] {
  let step: CGVector = CGVector(dx: rect.width / CGFloat(step.0),
                                dy: rect.height / CGFloat(step.1))
  return stride(rect, step: step)
}

public func stride(_ rect: CGRect, step: CGVector) -> [CGPoint] {
  var point: [CGPoint] = []
  for y in stride(from: rect.minY, through: rect.maxY, by: step.dy) {
    for x in stride(from: rect.minX, through: rect.maxX, by: step.dx) {
      point.append(CGPoint(x: x, y: y))
    }
  }
  return point
}

public func stride(from p1: CGPoint, to p2: CGPoint, distanceStep: CGFloat) -> [CGPoint] {
  let distance = p1.distance(to: p2)
  return stride(from: 0, to: distance, by: distanceStep).map {
    p1.interpolated(to: p2, by: $0)
  }
}

public func stride(from p1: CGPoint, through p2: CGPoint, distanceStep: CGFloat) -> [CGPoint] {
  let distance = p1.distance(to: p2)
  return stride(from: 0, through: distance, by: distanceStep).map {
    p1.interpolated(to: p2, by: $0)
  }
}

public func stride(from p1: CGPoint, to p2: CGPoint, in steps: Int) -> [CGPoint] {
  let distance = p1.distance(to: p2)
  let by = distance / CGFloat(steps)
  return stride(from: 0, to: distance, by: by).map {
    p1.interpolated(to: p2, by: $0)
  }
}

public func stride(from p1: CGPoint, through p2: CGPoint, in steps: Int) -> [CGPoint] {
  let distance = p1.distance(to: p2)
  let by = distance / CGFloat(steps)
  return stride(from: 0, through: distance, by: by).map {
    p1.interpolated(to: p2, by: $0)
  }
}
