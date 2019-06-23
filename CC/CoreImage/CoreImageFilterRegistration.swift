//
//  CoreImageFilterRegistration.swift
//  CC
//
//  Created by Sash Zats on 4/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

public class CoreImageFiltersRegistration: NSObject, CIFilterConstructor {

  private static let mapping: [String: CIFilter.Type] = [
    "CMYKToneCurves": CMYKToneCurves.self,
    "CMYKLevels": CMYKLevels.self,
    "CMYKRegistrationMismatch": CMYKRegistrationMismatch.self,
    "RGBChannelCompositing": RGBChannelCompositing.self,
    "RGBChannelToneCurve": RGBChannelToneCurve.self,
    "RGBChannelBrightnessAndContrast": RGBChannelBrightnessAndContrast.self,
    "ChromaticAberration": ChromaticAberration.self,
    "RGBChannelGaussianBlur": RGBChannelGaussianBlur.self,
  ]

  public static func registerFilters() {
    let constructor = CoreImageFiltersRegistration()
    for (name, _) in mapping {
      CIFilter.registerName(
        name,
        constructor: constructor,
        classAttributes: [
          kCIAttributeFilterCategories: ["Custom Filters"]
        ])
    }
  }

  private override init() {
  }

  public func filter(withName name: String) -> CIFilter? {
    if let ciFilterClas = CoreImageFiltersRegistration.mapping[name] {
      return ciFilterClas.init()
    }
    return nil
  }
}
