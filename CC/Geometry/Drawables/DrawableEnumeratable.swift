//
//  DrawableEnumeratable.swift
//  CC
//
//  Created by Sash Zats on 7/6/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public protocol DrawableEnumeratable {
  var vertices: [CGPoint] { get }
  var edges: [Line] { get }
}

extension Line: DrawableEnumeratable {
  public var vertices: [CGPoint] {
    return [a, b]
  }

  public var edges: [Line] {
    return [self]
  }
}

extension Polygon: DrawableEnumeratable {
  public var edges: [Line] {
    return self
      .vertices
      .appending(vertices[0])
      .enumerate(by: 2, step: 1)
      .dropLast()
      .map {
        Line(a: $0[0], b: $0[1])
      }
  }
}

extension Triangle: DrawableEnumeratable {
  public var vertices: [CGPoint] {
    return [a, b, c]
  }

  public var edges: [Line] {
    return [ab, bc, ca]
  }
}

extension Group: DrawableEnumeratable {
  public var vertices: [CGPoint] {
    return drawables.compactMap { ($0 as? DrawableEnumeratable)?.vertices }.flatMap { $0 }
  }

  public var edges: [Line] {
    return drawables.compactMap { ($0 as? DrawableEnumeratable)?.edges }.flatMap { $0 }
  }
}
