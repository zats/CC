//
//  Hatching.swift
//  CC
//
//  Created by Sash Zats on 6/23/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public extension Circle {
  func hatch(step: CGFloat = 2, angle: CGFloat = .pi / 4) -> [Line] {
    let bounds = self.bounds
    var result: [Line] = []
    let circle = Circle(center: bounds.center, radius: min(bounds.width, bounds.height) * 0.5)
    let directionLine = Line(center: circle.center,
                             direction: angle,
                             length: circle.radius * 2)
    if directionLine.length < step * 2 {
      // draw one line in the middle and bail
      let counterLine = Line(center: circle.center,
                             direction: angle + .pi / 2,
                             length: circle.radius * 2)
      result.append(counterLine)
    } else {
      let inSteps = Int(directionLine.length / step)
      for p in stride(from: directionLine.a, through: directionLine.b, in: inSteps) {
        let counterLine = Line(center: p, direction: angle + .pi / 2, length: circle.radius * 2)
        if let intersection = circle.intersection(with: counterLine), case let .two(p1, p2) = intersection {
          result.append(Line(a: p1, b: p2))
        }
      }
    }
    return result
  }

}
