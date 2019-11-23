//
//  Rounding.swift
//  CC
//
//  Created by Sash Zats on 7/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
  /**
   Rounds to a given digit

   - Parameter precision: number of digits after comma to round to
   */
  func rounded(to precision: Int) -> CGFloat {
    let accuracy = pow(10, CGFloat(precision))
    return (self * accuracy).rounded() / accuracy
  }
}


public extension CGPoint {
  func rounded(to precision: Int) -> CGPoint {
    return CGPoint(x: self.x.rounded(to: precision),
                   y: self.y.rounded(to: precision))
  }

  func equal(to other: CGPoint, precision: Int) -> Bool {
    return self.rounded(to: precision) == other.rounded(to: precision)
  }
}
