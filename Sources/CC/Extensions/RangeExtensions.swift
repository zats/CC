//
//  RangeExtensions.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public protocol Partitionable {
  func partition(in x: Int, _ fn: (Self) -> (slice: Self, remainder: Self)) -> [Self]
}
public extension Partitionable {
  func partition(in x: Int, _ fn: (Self) -> (slice: Self, remainder: Self)) -> [Self] {
    var result: [Self] = []
    var remainder = self
    for i in 0..<x {
      let (s, r) = fn(remainder)
      result.append(s)
      remainder = r
      if i == x - 1 {
        result.append(r)
      }
    }
    return result
  }
}

extension ClosedRange: Partitionable {}

extension Range: Partitionable {}
