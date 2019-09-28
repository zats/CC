import CoreGraphics

public extension CGRect {
  init(center: CGPoint = .zero, size: CGSize) {
    self.init(origin: CGPoint(x: center.x - size.width * 0.5,
                              y: center.y - size.height * 0.5),
              size: size)
  }

  init(center: CGPoint = .zero, edges: CGFloat) {
    self.init(center: center, size: CGSize(width: edges, height: edges))
  }

  var center: CGPoint {
    return CGPoint(x: midX, y: midY)
  }
  
  var precscribedCircleRadius: CGFloat {
    return min(width, height) * 0.5
  }
}

public extension CGRect {
  /**
   Breakes current rectange into `stepsX` horizontal and `stepsY` vertical rectanges
   */
  func split(in stepsX: Int, _ stepsY: Int) -> [CGRect] {
    let width = self.width / CGFloat(stepsX)
    let height = self.height / CGFloat(stepsY)

    var splitted: [CGRect] = []
    for x in 0..<stepsX {
      for y in 0..<stepsY {
        let currentRect = CGRect(x: CGFloat(x) * width + minX,
                                 y: CGFloat(y) * height + minY,
                                 width: width,
                                 height: height)
        splitted.append(currentRect)
      }
    }
    return splitted
  }

  mutating func setSizeMaintainingCenter(_ size: CGSize) {
    self.origin += CGPoint(x: (self.width - size.width) * 0.5,
                           y: (self.height - size.height) * 0.5)
    self.size = size
  }

  func settingSizeMaintainingCenter(_ size: CGSize) -> CGRect {
    var rect = self
    rect.setSizeMaintainingCenter(size)
    return rect
  }
}

public extension CGRect {
  var topLeft: CGPoint {
    return CGPoint(x: minX, y: minY)
  }

  var bottomRight: CGPoint {
    return CGPoint(x: maxX, y: maxY)
  }

  var topRight: CGPoint {
    return CGPoint(x: maxX, y: minY)
  }

  var bottomLeft: CGPoint {
    return CGPoint(x: minX, y: maxY)
  }
}

public extension CGRect {
  func extended(with point: CGPoint) -> CGRect {
    if self == .null {
      return CGRect(center: point, edges: 0)
    } else if self.contains(point) {
      return self
    }
    var result = self
    if point.x < result.minX {
      result.size.width += result.minX - point.x
      result.origin.x = point.x
    } else if point.x > result.maxX {
      result.size.width += point.x - result.maxX
    }
    if point.y < result.minY {
      result.size.height += result.minY - point.y
      result.origin.y = point.y
    } else if point.y > result.maxY {
      result.size.height += point.y - result.maxY
    }
    return result
  }
}

public extension CGRect{
  func center(in bounds: CGRect) -> CGPoint {
    return CGPoint(x: (bounds.width - self.width) * 0.5,
                   y: (bounds.height - self.height) * 0.5)
  }
}
