//
//  XPlatColor.swift
//  CC
//
//  Created by Sash Zats on 4/8/19.
//  Copyright © 2019 Sash Zats. All rights reserved.
//

import Foundation

#if os(iOS)
public typealias XPlatColor = UIColor
#elseif os(macOS)
public typealias XPlatColor = NSColor
#else
#error("Unsupported OS")
#endif
