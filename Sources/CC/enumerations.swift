//
//  enumerations.swift
//  CC
//
//  Created by Sash Zats on 7/6/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public extension Array {
  /**
   Retunrs an array containing every `by` elements groupped in the array

   Index advancment can be controlled independantly by controlling `step` argument

   If `step` is `nil`, it will be the same as `by`
   */
  func enumerate(by: Int, step: Int? = nil) -> [[Element]] {
    var result: [[Element]] = []
    for idx in stride(from: 0, to: self.count, by: step ?? by) {
      result.append(Array(self[idx..<Swift.min(idx+by, self.count)]))
    }
    return result
  }
}

public extension Sequence {
  func enumerated(by bunch: Int) -> [[Element]] {
    var result: [[Element]] = []
    var currentBatch: [Element] = []
    for (idx, elem) in self.enumerated() {
      if idx > 0 && idx % bunch == 0 {
        result.append(currentBatch)
        currentBatch = []
      } else {
        currentBatch.append(elem)
      }
    }
    if !currentBatch.isEmpty {
      result.append(currentBatch)
    }
    return result
  }
}
