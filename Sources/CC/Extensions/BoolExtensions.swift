//
//  BoolExtension.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics


public extension Bool {
  static func random(probability: CGFloat) -> Bool {
    return CGFloat.random(in: 0..<1) < probability
  }
}
