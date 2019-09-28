//
//  CustomHashable.swift
//  CC
//
//  Created by Sash Zats on 7/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public struct CustomHashable<T>: Hashable {

  public let value: T

  public typealias HashCalculator = (T, inout Hasher) -> Void
  public typealias EqualityCalculator = (T, T) -> Bool

  private let hashCalculator: HashCalculator
  private let equalityCalculator: EqualityCalculator

  public init(value: T, hashCalculator: @escaping HashCalculator, equalityCalculator: @escaping EqualityCalculator) {
    self.value = value
    self.hashCalculator = hashCalculator
    self.equalityCalculator = equalityCalculator
  }

  public static func == (lhs: CustomHashable<T>, rhs: CustomHashable<T>) -> Bool {
    return lhs.equalityCalculator(lhs.value, rhs.value)
  }

  public func hash(into hasher: inout Hasher) {
    hashCalculator(self.value, &hasher)
  }
}
