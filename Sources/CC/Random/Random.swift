//
//  Random.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

/// returns `a` over `b` with given `probability`
///
/// note `probability` from 0 to 1 inclusive
public func choose<T>(withProbability probability: CGFloat, between a: T, or b: T) -> T {
  return CGFloat.random(in: 0...1) <= probability ? a : b
}

public extension CGFloat {
  static func random(around: CGFloat, dispersion: CGFloat) -> CGFloat {
    return CGFloat.random(in: (around - dispersion)...(around + dispersion))
  }
}
