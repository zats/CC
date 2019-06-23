//
//  UIColor.swift
//  CC
//
//  Created by Sash Zats on 4/7/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import UIKit

public extension UIColor {
  convenience init(hex: String)  {
    let scanner = Scanner(string: hex)
    scanner.scanString("#", into: nil)
    var color: UInt32 = 0
    if scanner.scanHexInt32(&color) {
      self.init(hex: UInt(color))
    } else {
      self.init(white: 0, alpha: 1)
    }
  }

  convenience init(hex: UInt) {
    let r = CGFloat((hex & 0xff000000) >> 24) / 255
    let g = CGFloat((hex & 0x00ff0000) >> 16) / 255
    let b = CGFloat((hex & 0x0000ff00) >> 8) / 255
    let a = CGFloat(hex & 0x000000ff) / 255
    self.init(red: r, green: g, blue: b, alpha: a)
  }

  convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
    self.init(red: CGFloat(red) / 255,
              green: CGFloat(green) / 255,
              blue: CGFloat(blue) / 255,
              alpha: CGFloat(alpha) / 255)
  }

  convenience init(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
    let reverseK = 1 - black
    let r = (1 - cyan) * reverseK
    let g = (1 - magenta) * reverseK
    let b = (1 - yellow) * reverseK
    self.init(red: r, green: g, blue: b, alpha: 1)
  }

  func getRGB() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (red: r, green: g, blue: b, alpha: a)
  }

  func getCMYK() -> (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
    let rgb = self.getRGB()
    let k = min(1 - rgb.red, 1 - rgb.green, 1 - rgb.blue)
    if k == 1 {
      return (cyan: 0, magenta: 0, yellow: 0, black: 1)
    }
    let reverseK = 1 - k
    let c = (reverseK - rgb.red) / reverseK
    let m = (reverseK - rgb.green) / reverseK
    let y = (reverseK - rgb.blue) / reverseK
    return (cyan: c, magenta: m, yellow: y, black: k)
  }

  static func random(hue: Range<CGFloat>,
                     saturation: Range<CGFloat>,
                     brightness: Range<CGFloat>,
                     alpha: Range<CGFloat>) -> UIColor {
    return UIColor(hue: CGFloat.random(in: hue),
                   saturation: CGFloat.random(in: saturation),
                   brightness: CGFloat.random(in: brightness),
                   alpha: CGFloat.random(in: alpha))
  }

  static func random(hue: ClosedRange<CGFloat> = 0...1,
                     saturation: ClosedRange<CGFloat> = 0...1,
                     brightness: ClosedRange<CGFloat> = 0...1,
                     alpha: ClosedRange<CGFloat> = 0...1) -> UIColor {
    return UIColor(hue: CGFloat.random(in: hue),
                   saturation: CGFloat.random(in: saturation),
                   brightness: CGFloat.random(in: brightness),
                   alpha: CGFloat.random(in: alpha))
  }
}

