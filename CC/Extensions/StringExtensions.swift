//
//  StringExtensions.swift
//  CC
//
//  Created by Sash Zats on 6/27/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public extension String {
  #if os(iOS)
  static let defaultPathFlip = true
  #else
  static let defaultPathFlip = false
  #endif

  func path(using font: CTFont, flip: Bool = String.defaultPathFlip) -> CGPath {
    let textPath = CGMutablePath()

    let attributedString = NSAttributedString(string: self, attributes: [
      NSAttributedString.Key.font: font
    ])
    let line = CTLineCreateWithAttributedString(attributedString)

    // direct cast to typed array fails for some reason
    let runs = (CTLineGetGlyphRuns(line) as [AnyObject]) as! [CTRun]

    for run in runs
    {
      let count = CTRunGetGlyphCount(run)

      for index in 0..<count
      {
        let range = CFRangeMake(index, 1)

        var glyph = CGGlyph()
        CTRunGetGlyphs(run, range, &glyph)

        var position = CGPoint()
        CTRunGetPositions(run, range, &position)

        if let letterPath = CTFontCreatePathForGlyph(font, glyph, nil) {
          let transform = CGAffineTransform(translationX: position.x, y: position.y)
          textPath.addPath(letterPath, transform: transform)
        }
      }
    }
    if (flip) {
      var transform = CGAffineTransform.identity.scaledBy(x: 1, y: -1)
      return textPath.copy(using: &transform)!
    } else {
      return textPath
    }
  }
}
