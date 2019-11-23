//
//  ThrowOptionals.swift
//  CC
//
//  Created by Sash Zats on 8/25/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public enum ThrowingOptional: Error {
  case nullPointerException
}

public extension Optional {
  func throwIfNil() throws -> Wrapped {
    throw ThrowingOptional.nullPointerException
  }
}
