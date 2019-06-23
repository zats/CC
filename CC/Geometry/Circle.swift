//
//  Circle.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public struct Circle {
  public let center: CGPoint
  public let radius: CGFloat

  public init(center: CGPoint, radius: CGFloat) {
    self.center = center
    self.radius = radius
  }
}
