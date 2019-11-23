//
//  ArrayExtensions.swift
//  CC
//
//  Created by Sash Zats on 7/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public extension Array {
  func appending(_ element: Element) -> Array<Element> {
    var result = self
    result.append(element)
    return result
  }
}
