//
//  Iteration.swift
//  CC
//
//  Created by Sash Zats on 6/23/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Circle {
  func points(angleStep: CGFloat, offset: CGFloat = 0) -> [CGPoint] {
    var result: [CGPoint] = []
    for angle in stride(from: 0, to: CGFloat.pi * 2, by: angleStep) {
      result.append(CGPoint(angle: angle + offset, distance: radius, from: center))
    }
    return result
  }

  func points(count: Int, offset: CGFloat = 0) -> [CGPoint] {
    let angleStep = CGFloat.pi * 2 / CGFloat(count)
    return points(angleStep: angleStep, offset: offset)
  }
}
