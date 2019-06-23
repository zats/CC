//
//  Clamping.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public extension Comparable {
  func clamped(to range: Range<Self>) -> Self {
    if self < range.lowerBound {
      return range.lowerBound
    } else if self > range.upperBound {
      return range.upperBound
    } else {
      return self
    }
  }

  func clamped(to range: ClosedRange<Self>) -> Self {
    if self < range.lowerBound {
      return range.lowerBound
    } else if self >= range.upperBound {
      return range.upperBound
    } else {
      return self
    }
  }
}
