//
//  UIImageExtensions.swift
//  CC
//
//  Created by Sash Zats on 4/7/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import UIKit

public extension CGImage {
  func rgbaBytes() -> [UInt8] {
    let data = dataProvider!.data!
    let length = CFDataGetLength(data)
    print(length, width * height * 4)
    var rawData = [UInt8](repeating: 0, count: length)
    CFDataGetBytes(data, CFRange(location: 0, length: length), &rawData)
    return rawData
  }

  func rgbaBytes2() -> [UInt8]? {
    guard let dataProvider = self.dataProvider else {
      return nil
    }
    guard let data = dataProvider.data else {
      return nil
    }
    let length = CFDataGetLength(data)
    var rawData = [UInt8](repeating: 0, count: length)
    CFDataGetBytes(data, CFRange(location: 0, length: length), &rawData)
    return rawData
  }

  func enumerarePixels(fn: (_ x: Int, _ y: Int, _ pixels: [UInt8], _ stop: inout Bool) -> Void) {
    let pixels = self.rgbaBytes2()!
    var stop: Bool = false
    for y in 0..<height {
      for x in 0..<width {
        let index = (x + y * width) * 4
        fn(x, y,
           [pixels[index], pixels[index + 1], pixels[index + 2], pixels[index + 3]],
           &stop)
        if stop { return }
      }
    }
  }
}

public extension UIImage {
  func enumeratePixels(_ fn: (Int, Int, [UInt8], inout Bool) -> Void) {
    var stop = false
    let pixels = rgbaBytes()!
    for y in 0..<Int(size.height) {
      for x in 0..<Int(size.width) {
        let index = (x + y * Int(size.width)) * 4
        fn(x, y, [pixels[index], pixels[index+1], pixels[index+2], pixels[index+3]], &stop)
        if stop { return }
      }
    }
  }

  func enumeratePixels(_ fn: (CGPoint, UIColor, inout Bool) -> Void) {
    var stop = false
    let pixels = rgbaBytes()!
    for y in 0..<Int(size.height) {
      for x in 0..<Int(size.width) {
        let index = (x + y * Int(size.width)) * 4
        fn(CGPoint(x: CGFloat(x), y: CGFloat(y)),
           UIColor(red: pixels[index], green: pixels[index+1], blue: pixels[index+2], alpha: pixels[index+3]),
           &stop)
        if stop { return }
      }
    }
  }

  func pixelsArray() -> [[UIColor]] {
    var rows: [[UIColor]] = []
    let pixels = rgbaBytes()!
    for x in 0..<Int(size.width) {
      var column: [UIColor] = []
      for y in 0..<Int(size.height) {
        let index = (x + y * Int(size.width)) * 4
        column.append(UIColor(red: pixels[index], green: pixels[index+1], blue: pixels[index+2], alpha: pixels[index+3]))
      }
      rows.append(column)
    }
    return rows
  }

  func rgbaBytes() -> [UInt8]? {
    return cgImage?.rgbaBytes()
  }

  func color(atX x: Int, y: Int) -> UIColor {
    let pixelData = cgImage!.dataProvider!.data!
    let data = CFDataGetBytePtr(pixelData)!

    let pixelInfo: Int = (Int(size.width) * y + x) * 4

    let r = CGFloat(data[pixelInfo]) / 255
    let g = CGFloat(data[pixelInfo+1]) / 255
    let b = CGFloat(data[pixelInfo+2]) / 255
    let a = CGFloat(data[pixelInfo+3]) / 255

    return UIColor(red: r, green: g, blue: b, alpha: a)
  }

  struct Channels {
    public struct RGB: OptionSet {
      public static let red = RGB(rawValue: 1 << 0)
      public static let green = RGB(rawValue: 1 << 1)
      public static let blue = RGB(rawValue: 1 << 2)

      public let rawValue: Int
      public init(rawValue: Int) {
        self.rawValue = rawValue
      }
    }
  }
}
