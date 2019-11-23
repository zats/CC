//
//  UIImage+CoreImage.swift
//  CC
//
//  Created by Sash Zats on 4/7/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import UIKit
import CoreImage

public extension UIImage {
  func applyFilter(_ named: String, parameters: [String: Any]) -> UIImage {
    let ciImage = CIImage(cgImage: cgImage!)
      .applyingFilter("CIBicubicScaleTransform", parameters: ["inputScale": 0.5])
      .applyingFilter(named, parameters: parameters)
    return UIImage(ciImage: ciImage)
  }
}
