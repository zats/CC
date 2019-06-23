//
//  IntExtensions.swift
//  CC
//
//  Created by Sash Zats on 6/22/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public extension Int {
  var isOdd: Bool {
    return self % 2 != 0
  }

  var isEven: Bool {
    return self % 2 == 0
  }
}
