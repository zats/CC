//
//  Degrees.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
  func toDegrees() -> CGFloat {
    return self / .pi * 180
  }

  func toRadians() -> CGFloat {
    return self * .pi / 180
  }
}
