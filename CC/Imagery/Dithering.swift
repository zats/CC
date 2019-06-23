//
//  Dithering.swift
//  CC
//
//  Created by Sash Zats on 4/7/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import UIKit

public extension CGImage {

  static let floydSteinbergError: [[Double]] =
    [
      [0, 7/16],
      [3/16, 5/16, 1/16],
  ]

  private static func error(for pixel: Int) -> (value: Int, error: Int) {
    if pixel < 128 {
      return (value: 0, error: Int(pixel))
    } else {
      return (value: 255, error: -(255 - Int(pixel)))
    }
  }

  private static func distribute(_ error: Int, into pixels: inout [[Int]], at x: Int, _ y: Int, using diffusionError: [[Double]]) {
    let diffusionErrorOffset = diffusionError[1].count - diffusionError[0].count
    for (errY, errRow) in diffusionError.enumerated() {
      let tY = y + errY
      if tY >= pixels.count {
        break
      }

      for (errX, err) in errRow.enumerated() {
        if err == 0 { continue }
        let dX = errY == 0 ? errX : errX - diffusionErrorOffset
        let tX = x + dX
        if tX < 0 {
          continue
        } else if tX >= pixels[tY].count {
          break
        }
        if err != 0 {
          pixels[tY][tX] += Int(err * Double(error))
        }
      }
    }
  }

  func dither(errorDefinition: [[Double]], inverted: Bool = false) -> [CGPoint] {
    let pixels = self.rgbaBytes2()!
    var luminocity = pixels
      .enumerated()
      .filter { $0.offset % 4 == 0 }
      .map { Int($0.element) }

    for y in 0..<height {
      for x in 0..<width {
        let index = y * width + x
        let pixel = luminocity[index]
        let value = valueAndError(for: pixel)
        luminocity[index] = value.value
        distribute(error: value.error,
                   in: &luminocity,
                   at: x, y,
                   using: errorDefinition)
      }
    }
    return luminocity
      .enumerated()
      .filter { $0.element == (inverted ? 0 : 255) }
      .map {
        let y = $0.offset / width
        let x = $0.offset -  y * width
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
  }

  private func distribute(error: Int, in pixels: inout [Int], at x: Int, _ y: Int, using diffusionError: [[Double]]) {
    let diffusionErrorOffset = diffusionError[1].count - diffusionError[0].count
    for (errY, errRow) in diffusionError.enumerated() {
      let tY = y + errY
      if tY >= height {
        break
      }

      for (errX, err) in errRow.enumerated() {
        if err == 0 { continue }
        let dX = errY == 0 ? errX : errX - diffusionErrorOffset
        let tX = x + dX
        if tX < 0 {
          continue
        } else if tX >= width {
          break
        }
        if err != 0 {
          let index = tY * width + tX
          pixels[index] += Int(err * Double(error))
        }
      }
    }

  }

  private func valueAndError(for pixel: Int) -> (value: Int, error: Int) {
    if pixel < 128 {
      return (value: 0, error: Int(pixel))
    } else {
      return (value: 255, error: -(255 - Int(pixel)))
    }
  }

}
