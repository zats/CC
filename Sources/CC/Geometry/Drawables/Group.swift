//
//  Group.swift
//  CC
//
//  Created by Sash Zats on 7/6/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import CoreGraphics

public struct Group {
  public var drawables: [Drawable]
  public init(_ drawables: [Drawable]) {
    self.drawables = drawables
  }
}

extension Group: Drawable {
  public func draw(in context: CGContext) {
    drawables.forEach {
      $0.draw(in: context)
    }
  }

  public func transformed(_ t: CGAffineTransform) -> Group {
    return Group(drawables.map {
      $0.transformed(t)
    })
  }
}
